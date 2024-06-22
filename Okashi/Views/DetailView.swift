//
//  DetailView.swift
//  Okashi
//
//  Created by 堀ノ内海斗 on 2024/06/16.
//

import SwiftUI

struct DetailView: View {

    let name: String
    let kana: String
    let maker: String
    let price: String
    let type: String
    let regist: String
    let url: String
    let image: URL
    let comment: String

    // commentはHTML形式の文字列なので、表示できるように変換する
    var commentHtml: String {
        // HTMLタグを除去する
        comment.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }

    var body: some View {
        VStack {
            Text(name)
                .font(.title)
            VStack {
                AsyncImage(url: image) { image in
                    // 画像を表示する
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .padding()
                } placeholder: {
                    // 読込中はインジケーターを表示する
                    ProgressView()
                }
                Text(commentHtml)
                    .padding()
                HStack {
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("登録日")
                        Text("メーカー")
                        Text("価格")
                        Text("種類")
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(regist)
                        Text(maker)
                        Text("\(price)円")
                        Text(type)
                    }
                    Spacer()
                }
                // リンクを表示する
                Link("詳細はこちら（お菓子の虜ウェブサイト）", destination: URL(string: url)!)
                    .padding()
            }
        }
    }
}

