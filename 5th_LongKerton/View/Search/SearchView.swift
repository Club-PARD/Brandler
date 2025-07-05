//
//  ContentView.swift
//  SearchBar
//
//  Created by 정태주 on 6/29/25.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            SearchBarView(
                searchText: $viewModel.searchText,
                recentSearches: $viewModel.recentSearches,
                onCommit: {
                    viewModel.addToRecent(viewModel.searchText)
                    viewModel.isFocused = false
                }
            )

            // 🔍 검색 결과 리스트
            if !viewModel.searchText.isEmpty {
                if !viewModel.filteredItems.isEmpty {
                    List(viewModel.filteredItems) { item in
                        Text(item.name)
                    }
                    .listStyle(.plain)
                } else {
                    Text("검색 결과가 없습니다.")
                        .foregroundColor(.gray)
                        .padding()
                }
            }

            Spacer()
        }
        .onTapGesture {
            viewModel.isFocused = false
        }
    }
}

#Preview {
    SearchView()
}
