//
//  typeData.swift
//  Okashi
//
//  Created by 堀ノ内海斗 on 2024/06/22.
//

import SwiftUI

struct TypeItem: Identifiable{
    let id = UUID()
    let typeId: String
    let slug: String
    let name: String
}

// お菓子データ検索用のクラス
@Observable class TypeData {

    // JSONの構造
    struct json: Codable {
        // JSONのtype内のデータ構造
        struct Item: Codable {
            let id: String?
            let slug: String?
            let name: String?
        }
        // 複数要素
        let type: [Item]?
    }
    
    // お菓子のリスト
    var typeList: [TypeItem] = []

    // Web API検索用メソッド
    func serchType() {
        // Taskは非同期で処理を実行できる
        Task {
            // ここから先は非同期で実行される
            // 非同期でお菓子を検索する
            await search()
        }
    }

    @MainActor
    private func search() async {

        // リクエストURLの組み立て
        guard let req_url = URL(string: "https://www.sysbird.jp/webapi/?apikey=guest&list=type&format=json")
        else {
            return
        }

        print(req_url)

        do {
            // リクエストURLからダウンロード
            let (data, _) = try await URLSession.shared.data(from: req_url)

            // 受け取ったJSONデータをパースして格納

            let decoder = JSONDecoder()
            let json = try decoder.decode(json.self, from: data)

            // お菓子の情報が取得できているか確認
            guard let items = json.type else { return }
            // お菓子のリストを初期化
            typeList.removeAll()

            // 取得しているお菓子を構造体でまとめて管理
            for item in items {
                // お菓子の名称、掲載URL、画像URLをアンラップ
                if let id = item.id,
                let slug = item.slug,
                let name = item.name {
                    // １つのお菓子を構造体でまとめて管理
                    let type = TypeItem(
                        typeId: id,
                        slug: slug,
                        name: name
                    )
                    // お菓子の配列へ追加
                    typeList.append(type)
                }
            }
        } catch(let error) {
            print("エラーが出ました")
            print(error)
        }
    }
    
}
