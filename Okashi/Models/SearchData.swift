//
//  SearchData.swift
//  Okashi
//
//  Created by 堀ノ内海斗 on 2024/06/22.
//

import SwiftUI

// Identifiableプロトコルを利用して、お菓子の情報をまとめる構造体
struct OkashiItem: Identifiable{
    let id = UUID()
    let name: String
    let kana: String
    let maker: String
    let price: String
    let type: String
    let regist: String
    let url: String
    let image: URL
    let comment: String
    let shortComment: String
}

// お菓子データ検索用のクラス
@Observable class SearchData {

    enum Kana: Codable {
        case string(String)
        case dict([String: String])

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode(String.self) {
                self = .string(x)
                return
            }
            if let x = try? container.decode([String: String].self) {
                self = .dict(x)
                return
            }
            throw DecodingError.typeMismatch(Kana.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Kana"))
        }
    }
    
    // JSONの大枠構造
    struct FirstJson: Codable {
        let status: String
        let count: String
    }

    // JSONの構造
    struct ResultJson: Codable {
        // JSONのitem内のデータ構造
        struct Item: Codable {
            let name: String?
            let kana: Kana?
            let maker: String?
            let price: Kana?
            let type: String?
            let regist: String?
            let url: String?
            let image: URL?
            let comment: String?
        }
        // 複数要素
        let item: [Item]?

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            if let itemArray = try? container.decode([Item].self, forKey: .item) {
                item = itemArray
            } else if let singleItem = try? container.decode(Item.self, forKey: .item) {
                item = [singleItem]
            } else {
                throw DecodingError.dataCorruptedError(forKey: .item, in: container, debugDescription: "Item could not be decoded")
            }
        }

    }
    // お菓子のリスト
    var okashiList: [OkashiItem] = []

    // Web API検索用メソッド
    func serchOkashi(keyword: String, year: String, type: String, max: Int, offset: Int) {
        // Taskは非同期で処理を実行できる
        Task {
            // ここから先は非同期で実行される
            // 非同期でお菓子を検索する
            await search(keyword: keyword, year: year, type: type, max: max, offset: offset)
        }
    }

    // 非同期でお菓子データを取得
    // @MainActorを使いメインスレッドで更新する
    @MainActor
    private func search(keyword: String, year: String, type: String, max: Int, offset: Int) async {
        print(keyword)
        // お菓子の検索キーワードをURLエンコードする
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else {
            return
        }

        // リクエストURLの組み立て
        guard let req_url = URL(string: "https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_encode)&max=\(max)&order=d&year=\(year)&type=\(type)&offset=\(offset)")
        else {
            return
        }
        
        print(req_url)

        do {
            // リクエストURLからダウンロード
            let (data, _) = try await URLSession.shared.data(from: req_url)

            // 受け取ったJSONデータをパースして格納
            // 2重でデコードする

            // 1回目はデータ本体があるか確認するため
            let firstDecoder = JSONDecoder()
            let firstJson = try firstDecoder.decode(FirstJson.self, from: data)
            // countが0の場合は何もしない
            if firstJson.count == "0" {
                print("count == 0")
                okashiList.removeAll()
                return
            }

            let mainDecoder = JSONDecoder()
            let json = try mainDecoder.decode(ResultJson.self, from: data)

            // お菓子の情報が取得できているか確認
            guard let items = json.item else { return }
            // お菓子のリストを初期化
            okashiList.removeAll()

            // 取得しているお菓子を構造体でまとめて管理
            for item in items {
                // お菓子の名称、掲載URL、画像URLをアンラップ
                if let name = item.name,
                    let kana = item.kana,
                    let maker = item.maker,
                    let price = item.price,
                    let type = item.type,
                    let regist = item.regist,
                    let url = item.url,
                    let image = item.image,
                    let comment = item.comment {

                    // kanaが辞書の場合と文字列の場合で処理を分ける
                    let kanaString: String
                    switch kana {
                    case .string(let str):
                        kanaString = str
                    case .dict(_):
                        // 辞書の場合はダミーの文字列に変換
                        kanaString = "-"
                    }

                    let priceString: String
                    switch price {
                    case .string(let str):
                        priceString = str
                    case .dict(_):
                        // 辞書の場合はダミーの文字列に変換
                        priceString = "-"
                    }

                    // typeを日本語に変換
                    var typeString: String
                    switch type {
                        case "senbei":
                            typeString = "せんべい・和風"
                        case "cookie":
                            typeString = "クッキー・洋菓子"
                        case "snack":
                            typeString = "スナック"
                        case "chocolate":
                            typeString = "チョコレート"
                        case "candy":
                            typeString = "飴・ガム"
                        default:
                            typeString = "その他"
                    }

                    // htmlタグを削除
                    let commentString = comment.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)

                    // １つのお菓子を構造体でまとめて管理
                    let okashi = OkashiItem(
                        name: name,
                        kana: kanaString,
                        maker: maker,
                        price: priceString,
                        type: typeString,
                        regist: regist,
                        url: url,
                        image: image,
                        comment: commentString,
                        shortComment: String(commentString.prefix(50))
                    )
                    // お菓子の配列へ追加
                    okashiList.append(okashi)
                }
            }
        } catch(let error) {
            print("エラーが出ました")
            print(error)
        }
    }
}
