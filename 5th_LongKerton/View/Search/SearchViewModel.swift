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

    var allItems: [Product] = Product.brandItems

    // ✅ 필터된 브랜드 리스트
    var filteredItems: [Product] {
        if searchText.isEmpty {
            return []
        }
        return allItems.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    func addToRecent(_ term: String) {
        let trimmed = term.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        recentSearches.removeAll { $0 == trimmed }
        recentSearches.insert(trimmed, at: 0)

        if recentSearches.count > 10 {
            recentSearches.removeLast()
        }
    }
}
