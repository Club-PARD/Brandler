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
    var onCommit: () -> Void
    
    @FocusState private var isSearchFocused: Bool
    
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
                            .focused($isSearchFocused)
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
            // 🕓 최근 검색어 (최대 6개)
            
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
                            isSearchFocused = false
                        }
                    }
                }
                .padding(.top, 4)
            }
            else {
                Text("최근 검색이 없습니다.")
            }
        }
    }
}

//#Preview {
//    StatefulPreviewWrapper(initialValue: ("", ["브랜드 A", "브랜드 B", "트렌디 C", "빈티지 D", "미니멀 E", "스트릿 F"])) { searchText, recentSearches in
//        SearchBarView(
//            searchText: searchText,
//            recentSearches: recentSearches,
//            onCommit: {}
//        )
//    }
//}
////
//struct StatefulPreviewWrapper<Value1, Value2, Content: View>: View {
//    @State private var value1: Value1
//    @State private var value2: Value2
//    private let content: (Binding<Value1>, Binding<Value2>) -> Content
//
//    init(initialValue: (Value1, Value2), @ViewBuilder content: @escaping (Binding<Value1>, Binding<Value2>) -> Content) {
//        _value1 = State(initialValue: initialValue.0)
//        _value2 = State(initialValue: initialValue.1)
//        self.content = content
//    }
//
//    var body: some View {
//        content($value1, $value2)
//    }
//}
