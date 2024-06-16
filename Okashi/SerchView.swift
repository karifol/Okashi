//
//  SerchView.swift
//  Okashi
//
//  Created by 堀ノ内海斗 on 2024/06/16.
//
// お菓子検索ページ

import SwiftUI

struct SerchView: View {
    // OkashiDataを参照する変数
    var okashiDataList = SerchData()
    // 入力された文字列を保持する状態変数
    @State var inputText = ""
    
    var body: some View {
        VStack {
            // 文字を受け取るTextField
            TextField("キーワード",
                text: $inputText,
                prompt: Text("お菓子の名前を入力してください")
            )
            .foregroundColor(.white)
            .onSubmit {
                // 入力完了直後に検索する
                okashiDataList.serchOkashi(keyword: inputText)
            }
            // キーボードの改行を検索に反映する
            .submitLabel(.search)
            .padding()
            // リストを表示する
            List(okashiDataList.okashiList) { okashi in
                HStack {
                    // 画像を読み込み、表示する
                    AsyncImage(url: okashi.image) { image in
                        // 画像を表示する
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                    } placeholder: {
                        // 読込中はインジケーターを表示する
                        ProgressView()
                    }
                    Text(okashi.name)
                }
            }
        }
        // 半透明オレンジ
        .background(.orange)
    }
}

#Preview {
    SerchView()
}
