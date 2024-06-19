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

            ForEach(okashiDataList.okashiList) { okashi in
                Button {
                    self.okashiData = okashi
                } label: {
                    HStack {
                        AsyncImage(url: okashi.image) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(okashi.name)
                    }
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    MenueBarView()
}
