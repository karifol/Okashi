//
//  MenueView.swift
//  Okashi
//
//  Created by 堀ノ内海斗 on 2024/06/22.
//

import SwiftUI

struct MenueView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView
            // 中央に表示
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                // リンクを貼る
                HStack {
                    Spacer()
                    Text("このアプリで使用するお菓子のデータは\"お菓子の虜Web API\"を用いて取得しています")
                        .padding(.horizontal, 20)
                    Spacer()
                }
                Link("お菓子の虜Web API", destination: URL(string: "https://sysbird.jp/toriko/webapi/")!)
                    .padding(10)
                Spacer()
            }
            Spacer()
        }
    }
}

extension MenueView {
    private var headerView: some View {
        HStack {
            Image(systemName: "menucard")
            Text("メニュー")
        }
        .foregroundStyle(.white)
        .font(.title2)
        .frame(maxWidth: .infinity)
        .background(.orange)
        .fontWeight(.bold)
    }
}

#Preview {
    MenueView()
}
