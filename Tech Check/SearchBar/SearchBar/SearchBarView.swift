//
//  SearchBarView.swift
//  SearchBar
//
//  Created by 정태주 on 6/29/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @Binding var recentSearches: [String]
    var onCommit: () -> Void

    @FocusState private var isSearchFocused: Bool

    var body: some View {
        VStack(alignment: .leading) {
            // 🔍 검색 입력창
            TextField("Search...", text: $searchText, onCommit: onCommit)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($isSearchFocused)

            // 🕓 최근 검색어 (최대 6개)
            if !recentSearches.isEmpty {
                Text("Recent Searches")
                    .font(.headline)
                    .padding(.top)

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
        }
        .padding()
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
//
struct StatefulPreviewWrapper<Value1, Value2, Content: View>: View {
    @State private var value1: Value1
    @State private var value2: Value2
    private let content: (Binding<Value1>, Binding<Value2>) -> Content

    init(initialValue: (Value1, Value2), @ViewBuilder content: @escaping (Binding<Value1>, Binding<Value2>) -> Content) {
        _value1 = State(initialValue: initialValue.0)
        _value2 = State(initialValue: initialValue.1)
        self.content = content
    }

    var body: some View {
        content($value1, $value2)
    }
}
