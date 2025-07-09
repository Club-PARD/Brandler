import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var recentSearches: [String] = []
    @Published var isFocused: Bool = false
    @Published var selectedType: SearchType = .brand

    @Published var brandResults: [SearchBrand] = []
    @Published var productResults: [SearchProduct] = []

    private let api = SearchAPI()

    func search() async {
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            brandResults = []
            productResults = []
            return
        }

        do {
            switch selectedType {
            case .brand:
                brandResults = try await api.searchBrand(keyword: trimmed)
            case .product:
                productResults = try await api.searchProduct(keyword: trimmed)
            }
        } catch {
            print("❌ 검색 실패: \(error.localizedDescription)")
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

    // View에서 사용하는 computed results
    var filteredResults: [Any] {
        switch selectedType {
        case .brand: return brandResults
        case .product: return productResults
        }
    }
}
