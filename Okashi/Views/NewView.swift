//
//  NewView.swift
//  Okashi
//
//  Created by 堀ノ内海斗 on 2024/06/19.
//

import SwiftUI

struct NewView: View {

    var okashiDataList = SearchData()
    @State private var okashiData: OkashiItem? = nil
    init(){
        okashiDataList.serchOkashi(keyword: "", year: "", type: "")
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "wand.and.stars")
                Text("NEW")
            }
            .foregroundStyle(.white)
            .font(.title2)
            .frame(maxWidth: .infinity)
            .background(.orange)
            .fontWeight(.bold)

            ScrollView {
                ForEach(okashiDataList.okashiList) { okashi in
                    HStack {
                        Spacer()
                        VStack {
                            Text(okashi.regist)
                                .foregroundStyle(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(okashi.name)
                                .font(.title2)
                                .foregroundStyle(.black)
                                // bold
                                .fontWeight(.bold)
                            HStack {
                                AsyncImage(url: okashi.image) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 100)
                                } placeholder: {
                                    ProgressView()
                                }
                                VStack {
                                    Text(okashi.shortComment + "...")
                                        .foregroundStyle(.black)
                                    Button {
                                        self.okashiData = okashi
                                    } label: {
                                        Text("続きはこちら")
                                            .foregroundStyle(.blue)
                                            .underline()
                                    }
                                    // 右下に表示
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                            }

                            Divider()
                            HStack {
                                Text(okashi.maker)
                                    .foregroundStyle(.black)
                                Text(okashi.price + "円")
                                    .foregroundStyle(.black)
                            }
                        }
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity-10)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 2)
                        )
                        Spacer()
                    }
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
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

#Preview {
    MenueBarView()
}
