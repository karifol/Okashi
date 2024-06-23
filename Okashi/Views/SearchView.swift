//
//  SearchView.swift
//  Okashi
//
//  Created by 堀ノ内海斗 on 2024/06/22.
//

import SwiftUI

struct SearchView: View {

    @State private var selectedYear = ""
    @State private var selectedType = ""
    @State var inputText = ""

    // お菓子の種類
    var typeDataList = TypeData()
    @State private var typeData: TypeItem? = nil
    init(){
        typeDataList.serchType()
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                headerView
                VStack(alignment: .center){
                    Spacer()
                    // キーワード
                    keywordView
                    // 検索メニュー
                    yearView
                    typeView
                    // 検索ボタン
                    searchButtonView
                    Spacer()
                }
                .frame(maxWidth: .infinity-20)
                Spacer()
            }
        }
    }
}

extension SearchView {
    private var headerView: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            Text("検索")
        }
        .foregroundStyle(.white)
        .font(.title2)
        .frame(maxWidth: .infinity)
        .background(.orange)
        .fontWeight(.bold)
    }

    private var keywordView: some View {
        HStack {
            TitleView(text: "キーワード")
            TextField("キーワード",
                text: $inputText,
                prompt: Text("お菓子の名前")
            )
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.orange, lineWidth: 2)
            )
        }
        .frame(maxWidth: .infinity-20)
        .padding(.horizontal, 50)
        .padding(.top, 50)

    }

    private var searchButtonView: some View {
        NavigationLink{
            SearchResultView(
                keyword: inputText,
                year: selectedYear,
                type: selectedType
            )
            .toolbar(.hidden)
        } label:{
            Text("検索")
                .font(.title2)
                .bold()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .foregroundColor(.orange)
        .overlay(
            RoundedRectangle(cornerRadius: 50)
                .stroke(Color.orange, lineWidth: 2)
        )
    }

    private struct TitleView: View {
        let text: String;
        var body: some View {
            Text(text)
                .font(.title2)
                .bold()
        }
    }
    
    private var yearView: some View {
        HStack {
            TitleView(text: "登録年")
            Spacer()
            Picker("Options", selection: $selectedYear) {
                Text("全年").tag("")
                ForEach((1990...2024).reversed(), id: \.self) { year in
                    let yearStr = String(year).replacingOccurrences(of: ",", with: "")
                    Text(yearStr).tag(yearStr)
                }
            }
            .pickerStyle(.menu)
        }
        .frame(maxWidth: .infinity-20)
        .padding(.horizontal, 50)
    }

    private var typeView: some View {
        HStack {
            TitleView(text: "種類")
            Spacer()
            Picker("Options", selection: $selectedType) {
                Text("全種").tag("")
                ForEach(typeDataList.typeList){ type in
                    Text(type.name).tag(type.typeId)
                }
            }
            .pickerStyle(.menu)
        }
        .frame(maxWidth: .infinity-20)
        .padding(.horizontal, 50)
    }
}

#Preview {
    SearchView()
}
