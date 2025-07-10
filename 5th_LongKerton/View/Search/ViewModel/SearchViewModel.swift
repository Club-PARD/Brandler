import Foundation

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var recentSearches: [String] = []
    @Published var isFocused: Bool = false
    @Published var selectedType: SearchType = .brand

//    var allBrands: [SearchBrand] = SearchBrand.sampleData
//    var allProducts: [SearchProduct] = SearchProduct.brandItems

    var filteredResults: [Any] {
        guard !searchText.isEmpty else { return [] }

        switch selectedType {
        case .brand:
            return allBrands.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        case .product:
            return allProducts.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    
    

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





