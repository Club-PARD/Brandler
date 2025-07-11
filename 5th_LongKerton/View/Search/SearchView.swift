import SwiftUI

struct SearchView: View {
    
    @Binding var currentState: AppState
    @Binding var previousState: AppState

    @StateObject private var viewModel = SearchViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var isSearching: Bool = false
    @State private var hasSearched: Bool = false

    var body: some View {
        ZStack {
            Color.BgColor.ignoresSafeArea()

            VStack(alignment: .leading) {
                // 뒤로가기 + 탭 선택
                HStack {
                    Button(action: {
                        currentState = previousState
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.custom("Pretendard-Medium", size: 18))
                            .foregroundColor(Color(white: 0.9))
                    }

                    SearchSelectView(selectedType: $viewModel.selectedType)
                        .padding(.leading, 10)
                        .offset(x: -25)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)

                // ✅ SearchBarView에 refreshTrigger 바인딩 전달
                SearchBarView(
                    currentState: $currentState,
                    previousState: $previousState,
                    searchText: $viewModel.searchText,
                    isSearch: $isSearching,
                    recentSearches: $viewModel.recentSearches,
                    isFocused: $viewModel.isFocused,
                    selectedType: $viewModel.selectedType,
                    filteredResults: viewModel.filteredResults,
                    hasSearched: $hasSearched,
                    onCommit: {
                        Task {
                            viewModel.addToRecent(viewModel.searchText)
                            viewModel.isFocused = false
                            hasSearched = true
                            await viewModel.search()
                        }
                    }
                )

                Spacer()
            }
            .onTapGesture {
                viewModel.isFocused = false
            }
            .navigationBarBackButtonHidden()
        }
    }
}
