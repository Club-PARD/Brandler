//
//  SearchBarView.swift
//  SearchBar
//
//  Created by 정태주 on 6/29/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @Binding var isSearch: Bool
    @Binding var recentSearches: [String]
    @Binding var isFocused: Bool   // 추가
    
    var onCommit: () -> Void
    
    @FocusState private var isSearchFocusedInternal: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ZStack(alignment: .leading) {
                    if searchText.isEmpty {
                        Text("브랜드를 검색해보세요.")
                            .foregroundColor(Color.nickBoxStroke)
                            .font(.custom("Pretendard-Medium", size: 12))
                            .padding(.leading, 11)
                    }

                    TextField("", text: $searchText, onCommit: onCommit)
                        .font(.custom("Pretendard-Medium", size: 12))
                        .padding(.leading, 11)
                        .foregroundColor(Color.nickBoxStroke)
                        .focused($isSearchFocusedInternal)
                        .onChange(of: isSearchFocusedInternal) { newValue in
                            isFocused = newValue  // 외부 바인딩에 상태 전달
                        }
                }
                
                Button(action:{
                    isSearch = true
                }){
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.nickBoxStroke)
                        .padding(.trailing, 16)
                }
            }
            .frame(height: 34)
            .background(Color.nickBox)
            .clipShape(Rectangle())
            .cornerRadius(15)
            .padding(.horizontal, 20)
            
            // 포커스가 있을 때만 최근 검색어 영역 표시
            if isFocused {
                if !recentSearches.isEmpty {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3), spacing: 8) {
                        ForEach(recentSearches.prefix(6), id: \.self) { item in
                            HStack(spacing: 4) {
                                Text(item)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                
                                Spacer(minLength: 4)
                                
                                Button(action: {
                                    recentSearches.removeAll { $0 == item }
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(16)
                            .onTapGesture {
                                searchText = item
                                isSearchFocusedInternal = false
                            }
                        }
                    }
                    .padding(.top, 4)
                    .padding(.horizontal, 19)
                } else {
                    Text("최근 검색이 없습니다.")
                        .foregroundColor(.gray)
                        .padding(.top, 8)
                        .padding(.horizontal, 19)
                }
            }
        }
    }
}
#Preview {
    StatefulPreviewWrapper2(
        ("", false, ["오버사이즈 후디", "테크 조거 팬츠", "레더 크로스백"], false)
    ) { searchText, isSearch, recentSearches, isFocused in
        SearchBarView(
            searchText: searchText,
            isSearch: isSearch,
            recentSearches: recentSearches,
            isFocused: isFocused,
            onCommit: {
                print("🔍 검색 실행됨: \(searchText.wrappedValue)")
            }
        )
    }
}
