import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @Binding var isSearch: Bool
    @Binding var recentSearches: [String]
    @Binding var isFocused: Bool
    
    @Binding var selectedType: SearchType
    let filteredResults: [Any]
    @Binding var hasSearched: Bool
    
    var onCommit: () -> Void
    
    @FocusState private var isSearchFocusedInternal: Bool
    let columns = [GridItem(.fixed(173)), GridItem(.fixed(173))]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            searchField
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
            
            if isFocused || searchText.isEmpty {
                recentSearchesSection
            } else {
                searchResultsSection
            }
        }
    }
    
    // MARK: - 검색창
    private var searchField: some View {
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
                    .onChange(of: isSearchFocusedInternal) { isFocused = $0 }
            }
            
            Button {
                isSearch = true
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.nickBoxStroke)
                    .padding(.trailing, 16)
            }
        }
        .frame(height: 34)
        .background(Color.nickBox)
        .cornerRadius(15)
    }
    
    // MARK: - 최근 검색어
    private var recentSearchesSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("최근 검색어")
                .font(.custom("Pretendard-Medium", size: 18))
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.top, 27)
            
            if recentSearches.isEmpty {
                Text("최근 검색어가 없습니다.")
                    .font(.custom("Pretendard-Medium", size: 14))
                    .foregroundColor(Color.EmptyFontColor)
                    .padding(.horizontal, 20)
                    .offset(x: 116, y: 113)
            } else {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4.5), count: 2), spacing: 19) {
                    ForEach(recentSearches.prefix(6), id: \.self) { item in
                        HStack(spacing: 4) {
                            Text(item)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .foregroundColor(.white).opacity(0.5)
                            
                            Button {
                                recentSearches.removeAll { $0 == item }
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray).opacity(0.5)
                                    .offset(x: 10)
                            }
                        }
                        .padding(.horizontal, 22.5)
                        .padding(.vertical, 8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(16)
                        .frame(width: 166, alignment: .leading)
                        .onTapGesture {
                            searchText = item
                            isSearchFocusedInternal = false
                            onCommit()
                        }
                    }
                }
//                .padding(.horizontal, 20)
                .padding(.top,19)
            }
        }
    }
    
    // MARK: - 검색 결과
    private var searchResultsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("검색 결과")
                .font(.custom("Pretendard-Medium", size: 18))
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.top, 15)
            
            if filteredResults.isEmpty {
                Text(selectedType == .brand ? "브랜드가 존재하지 않습니다." : "상품이 존재하지 않습니다.")
                    .foregroundColor(Color.EmptyFontColor)
                    .padding(.horizontal, 20)
                    .offset(x: 99, y: 109)
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(filteredResults.indices, id: \.self) { index in
                            if selectedType == .brand,
                               let brand = filteredResults[index] as? SearchBrand {
                                SearchBrandCardView(brand: brand)
                            } else if selectedType == .product,
                                      let product = filteredResults[index] as? SearchProduct {
                                SearchProductCardView(product: product)
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                }
            }
        }
        .padding(.top, 4)
    }
}

#Preview {
    SearchBarPreviewContainer()
}


private struct SearchBarPreviewContainer: View {
    @State private var searchText = "오버사이즈"
    @State private var isSearch = true
    @State private var recentSearches = ["오버사이즈 후디", "테크 조거 팬츠", "레더 크로스백"]
    @State private var isFocused = false
    @State private var selectedType: SearchType = .product
    @State private var hasSearched = true   // 여기 추가!
    
    var filteredResults: [Any] {
        switch selectedType {
            case .brand:
                return SearchBrand.sampleData.filter { $0.name.contains(searchText) }
            case .product:
                return SearchProduct.brandItems.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
        SearchBarView(
            searchText: $searchText,
            isSearch: $isSearch,
            recentSearches: $recentSearches,
            isFocused: $isFocused,
            selectedType: $selectedType,
            filteredResults: filteredResults,
            hasSearched: $hasSearched,   // 여기도 전달!
            onCommit: {
                print("🔍 검색 실행됨: \(searchText)")
            }
        )
    }
}
