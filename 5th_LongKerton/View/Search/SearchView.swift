//
//  ContentView.swift
//  SearchBar
//
//  Created by 정태주 on 6/29/25.
//

import SwiftUI
struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var isSearching: Bool = false
    
    var body: some View {
        ZStack {
            Color.BgColor.ignoresSafeArea()
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.custom("Pretendard-Medium", size: 18))
                            .foregroundColor(Color(white: 0.9))
                    }
                    
                    SearchSelectView()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 26)
                
                SearchBarView(
                    searchText: $viewModel.searchText,
                    isSearch: $isSearching,
                    recentSearches: $viewModel.recentSearches,
                    isFocused: $viewModel.isFocused, // 추가됨
                    onCommit: {
                        viewModel.addToRecent(viewModel.searchText)
                        viewModel.isFocused = false
                    }
                )
                
                // 🔍 검색 결과 리스트
                if viewModel.isFocused {
                    // 포커스 중일 때 최근 검색어만 표시 (이건 SearchBarView 내부에서 따로 처리하므로 필요 없을 수도 있음)
                    EmptyView()
                } else {
                    VStack(alignment: .leading) {
                        Text("검색 결과")
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.top, 27)
                        
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
                    }
                }
                
                Spacer()
            }
            .onTapGesture {
                viewModel.isFocused = false
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    SearchView()
}
