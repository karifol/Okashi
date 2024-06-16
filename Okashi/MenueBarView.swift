//
//  MenueBarView.swift
//  Okashi
//
//  Created by 堀ノ内海斗 on 2024/06/16.
//

import SwiftUI

struct MenueBarView: View {

    var body: some View {
        TabView{
            Text("1")
                .tabItem {
                    Image(systemName: "menucard")
                    Text("メニュー")
                }
            SerchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("検索")
                }
            Text("3")
                .tabItem {
                    Image(systemName: "wand.and.stars")
                    Text("新商品")
                }
            Text("4")
                .tabItem {
                    Image(systemName: "map")
                    Text("地域限定")
                }
            Text("5")
                .tabItem {
                    Image(systemName: "figure.and.child.holdinghands")
                    Text("年代別")
                }
        }
        .accentColor(.orange)
    }
}

#Preview {
    MenueBarView()
}
