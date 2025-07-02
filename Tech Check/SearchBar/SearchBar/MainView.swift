import SwiftUI

struct MainView: View {
    @State private var isSearching = false
    @Namespace private var searchNamespace

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                VStack {
                    Spacer()
                        .frame(height: geometry.size.height * (1.0 / 3.0)) // 하단 2/3 지점

                    // 🔍 검색 버튼
                    Button(action: {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.85)) {
                            isSearching = true
                        }
                    }) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("브랜드 검색")
                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .matchedGeometryEffect(id: "searchBar", in: searchNamespace)
                        .padding(.horizontal)
                    }

                    Spacer()
                }

                // 🔄 ContentView 전환
                if isSearching {
                    ContentView(isPresented: $isSearching, namespace: searchNamespace)
                        .transition(.opacity) // ✅ 딜레이 없는 전환
                        .zIndex(1)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    MainView()
}
