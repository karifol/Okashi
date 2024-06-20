//
//  NewView.swift
//  Okashi
//
//  Created by 堀ノ内海斗 on 2024/06/19.
//

import SwiftUI

struct NewView: View {

    var okashiDataList = SerchData()
    @State private var okashiData: OkashiItem? = nil
    init(){
        okashiDataList.serchOkashi(keyword: "")
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("新登録お菓子")
                .foregroundStyle(.white)
                .font(.title)
                .frame(maxWidth: .infinity)
                .padding(.bottom)
                .background(.orange)
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
                            AsyncImage(url: okashi.image) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                            } placeholder: {
                                ProgressView()
                            }
                            Text(okashi.shortComment + "...")
                                .foregroundStyle(.black)
                            Button {
                                self.okashiData = okashi
                            } label: {
                                Text("続きはこちら")
                                    .foregroundStyle(.blue)
                                    .underline()
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
