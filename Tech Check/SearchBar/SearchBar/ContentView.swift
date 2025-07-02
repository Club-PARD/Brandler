//
//  ContentView.swift
//  SearchBar
//
//  Created by 정태주 on 6/29/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SearchViewModel()

    // ✅ MainView에서 전달받을 값들
    @Binding var isPresented: Bool
    var namespace: Namespace.ID

    var body: some View {
        VStack(spacing: 0) {
            // 🔙 닫기 버튼
            HStack {
                Button(action: {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                        isPresented = false
                    }
                }) {
                    Image(systemName: "chevron.down")
                        .foregroundColor(.blue)
                        .padding()
                }
                Spacer()
            }

            // 🔍 애니메이션 연결된 검색창
            SearchBarView(
                searchText: $viewModel.searchText,
                recentSearches: $viewModel.recentSearches,
                onCommit: {
                    viewModel.addToRecent(viewModel.searchText)
                    viewModel.isFocused = false
                }
            )
            .matchedGeometryEffect(id: "searchBar", in: namespace)
            .padding(.horizontal)


            // 🔍 검색 결과
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
        .background(Color.white.ignoresSafeArea())
        .onTapGesture {
            viewModel.isFocused = false
        }
    }
}


