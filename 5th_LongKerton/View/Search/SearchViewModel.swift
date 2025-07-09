//
//  SearchViewModel.swift
//  SearchBar
//
//  Created by 정태주 on 6/29/25.
//
//
//  SearchViewModel.swift
//  SearchBar
//
//  Created by 정태주 on 6/29/25.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var recentSearches: [String] = []
    @Published var isFocused: Bool = false

    // ✅ 전체 상품 리스트 (Search 전용 mock data)
    var allItems: [SearchProduct] = SearchProduct.brandItems

    // ✅ 필터된 상품 리스트
    var filteredItems: [SearchProduct] {
        if searchText.isEmpty {
            return []
        }
        return allItems.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    // ✅ 최근 검색어에 추가
    func addToRecent(_ term: String) {
        let trimmed = term.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        recentSearches.removeAll { $0 == trimmed }
        recentSearches.insert(trimmed, at: 0)

        if recentSearches.count > 6 {
            recentSearches.removeLast()
        }
    }
}
