//
//  SearchResultView.swift
//  Okashi
//
//  Created by 堀ノ内海斗 on 2024/06/22.
//

import SwiftUI

struct SearchResultView: View {

    @Environment(\.dismiss) private var dismiss

    // 引数
    let keyword: String
    let year: String
    let type: String

    // 検索
    var okashiDataList = SearchData()
    @State private var isSheetPresented = false
    @State private var okashiData: OkashiItem? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            headerView

            if okashiDataList.okashiList.isEmpty {
                HStack {
                    Spacer()
                    Text("検索結果がありません")
                        .foregroundColor(.gray)
                        .padding(.vertical, 10)
                    Spacer()
                }
                Spacer()
            } else {
                HStack {
                    Spacer()
                    Text("検索結果を最大10件まで表示しています")
                    Spacer()
                }
                .foregroundColor(.gray)
                .padding(.vertical, 10)
                .background(.ultraThinMaterial)
                List(okashiDataList.okashiList) { okashi in
                    Button {
                        okashiData = okashi
                    } label: {
                        listItemView(imageName: okashi.image, label: okashi.name)
                    }
                }
            }
        }
        .onAppear {
            okashiDataList.serchOkashi(keyword: keyword, year: year, type: type)
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

extension SearchResultView {

    private var backwardView: some View {
        // 左に寄せる
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                Text("戻る")
                    .foregroundStyle(.white)
                    .bold()
            }
            Spacer()
        }
        .padding(.horizontal, 10)
    }

    private var headerView: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            Text("検索結果")
        }
        .foregroundStyle(.white)
        .font(.title2)
        .frame(maxWidth: .infinity)
        .background(.orange)
        .fontWeight(.bold)
        .overlay(
            // Navigation area
            backwardView
            , alignment: .top
        )
    }

    private struct listItemView: View {
        let imageName: URL
        let label: String
        var body: some View {
            HStack {
                // 画像を読み込み、表示する
                AsyncImage(url: imageName) { image in
                    // 画像を表示する
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                } placeholder: {
                    // 読込中はインジケーターを表示する
                    ProgressView()
                }
                Text(label)
            }
        }
    }
}

#Preview {
    SearchResultView(
        keyword: "",
        year: "2025",
        type: ""
    )
}
