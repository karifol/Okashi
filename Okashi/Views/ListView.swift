//
//  ListView.swift
//  Okashi
//
//  Created by 堀ノ内海斗 on 2024/06/22.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView
            Spacer()
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
}

#Preview {
    ListView()
}
