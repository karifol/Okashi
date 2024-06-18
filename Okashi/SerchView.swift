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
    @State private var isSheetPresented = false
    @State private var okashiData: OkashiItem? = nil
    
    init(){
        okashiDataList.serchOkashi(keyword: inputText)
        okashiData = okashiDataList.okashiList.first
    }
    
    var body: some View {
        VStack {
            VStack{
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
            }
            // 半透明オレンジ
            .background(.orange)

            // リスト切り替え用の矢印ボタン
            Button {
                // お菓子データを検索する
                okashiDataList.serchOkashi(keyword: inputText)
            } label: {
                HStack {
                    Text("再検索")
                    Image(systemName: "arrow.up.arrow.down.circle.fill")
                        .font(.title)
                }

            }

            // リストを表示する
            List(okashiDataList.okashiList) { okashi in
                Button {
                    self.okashiData = okashi
                } label: {
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
                .sheet(item: $okashiData) { okashi in
                    DetailView(
                        name: okashi.name,
                        kana: okashi.kana,
                        maker: okashi.maker,
                        price: okashi.price,
                        type: okashi.type,
                        regist: okashi.regist,
                        url: okashi.url,
                        image: okashi.image,
                        comment: okashi.comment
                    )
                }
            }
        }


    }
}

#Preview {
    SerchView()
}
