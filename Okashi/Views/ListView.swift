//
//  ListView.swift
//  Okashi
//
//  Created by 堀ノ内海斗 on 2024/06/22.
//

import SwiftUI

struct ListView: View {
    
    // ページ番号
    @State var page: Int = 1
    
    var okashiDataList = SearchData()
    @State private var okashiData: OkashiItem? = nil
    init(){
        okashiDataList.serchOkashi(keyword: "", year: "", type: "", max:10, offset:0)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView
            HStack {
                Spacer()
                Button{
                    if (page > 1) {
                        page = page - 1
                        let offset = (page-1) * 10
                        okashiDataList.serchOkashi(keyword: "", year: "", type: "", max:10, offset:offset)
                    }
                } label: {
                    Image(systemName: "lessthan")
                        .foregroundColor(.orange)
                }
                .padding(.horizontal, 10)
                Text("\(page)")
                    .font(.title)
                Button{
                    page = page + 1
                    let offset = (page-1) * 10
                    okashiDataList.serchOkashi(keyword: "", year: "", type: "", max:10, offset:offset)
                } label: {
                    Image(systemName: "greaterthan")
                        .foregroundColor(.orange)
                }
                .padding(.horizontal, 10)
                Spacer()
            }
            .font(.title2)
            .bold()
            .padding(.top, 20)
            .background(.ultraThinMaterial)
            List(okashiDataList.okashiList) { okashi in
                Button {
                    okashiData = okashi
                } label: {
                    listItemView(imageName: okashi.image, label: okashi.name)
                }
            }
            Spacer()
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

extension ListView {
    private var headerView: some View {
        HStack {
            Image(systemName: "list.bullet.clipboard")
            Text("一覧")
        }
        .foregroundStyle(.white)
        .font(.title2)
        .frame(maxWidth: .infinity)
        .background(.orange)
        .fontWeight(.bold)
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
    ListView()
}
