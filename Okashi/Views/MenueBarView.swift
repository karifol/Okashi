//
//  MenueBarView.swift
//  Okashi
//
//  Created by 堀ノ内海斗 on 2024/06/16.
//

import SwiftUI

struct MenueBarView: View {
    
    @State var selection: Int = 1

    var body: some View {
        TabView(selection: $selection) {
            MenueView()
                .tabItem {
                    Image(systemName: "menucard")
                    Text("メニュー")
                }
                .tag(0)
            NewView()
                .tabItem {
                    Image(systemName: "wand.and.stars")
                    Text("NEW")
                }
                .tag(1)
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("検索")
                }
                .tag(2)
            ListView()
                .tabItem {
                    Image(systemName: "list.bullet.clipboard")
                    Text("一覧")
                }
                .tag(3)
        }
        .accentColor(.orange)
    }
}

#Preview {
    MenueBarView()
}
