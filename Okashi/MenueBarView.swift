//
//  MenueBarView.swift
//  Okashi
//
//  Created by 堀ノ内海斗 on 2024/06/16.
//

import SwiftUI

struct MenueBarView: View {
    
    @State var selection: Int = 2

    var body: some View {
        TabView(selection: $selection) {
            Text("1")
                .tabItem {
                    Image(systemName: "menucard")
                    Text("メニュー")
                }
                .tag(0)
            SerchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("検索")
                }
                .tag(1)
            NewView()
                .tabItem {
                    Image(systemName: "wand.and.stars")
                    Text("NEW")
                }
                .tag(2)
            Text("4")
                .tabItem {
                    Image(systemName: "map")
                    Text("地域限定")
                }
                .tag(3)
            Text("5")
                .tabItem {
                    Image(systemName: "figure.and.child.holdinghands")
                    Text("年代別")
                }
                .tag(4)
        }
        .accentColor(.orange)
    }
}

#Preview {
    MenueBarView()
}
