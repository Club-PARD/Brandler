import SwiftUI

struct BrandPage: View {
    @StateObject private var viewModel = BrandPageViewModel()

    var body: some View {
        ZStack(alignment: .top) {
            Color.black.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    // 🔹 배너 뷰 + 스크롤 위치 추적
                    GeometryReader { geo in
                        BrandBannerView()
                            .frame(height: viewModel.bannerHeight)
                            .onAppear {
                                viewModel.updateScrollOffset(-geo.frame(in: .named("scroll")).minY)
                            }
                            .onChange(of: geo.frame(in: .named("scroll")).minY) { newOffset in
                                viewModel.updateScrollOffset(-newOffset)
                            }
                    }
                    .frame(height: viewModel.bannerHeight)

                    // 🔹 탭바 + 아이템 그리드 전체를 하나의 블록으로 offset 적용
                    VStack(spacing: 0) {
                        // 🔸 탭바
                        CategoryTabBarView(selected: $viewModel.selectedCategory)
                            .padding(.horizontal)
                            .padding(.top, 12)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(Color.black)

                        // 🔸 아이템 그리드
                        ItemGridView()
                            .padding(.bottom, 100)
                    }
                    .offset(y: tabGroupOffset) // ✅ 탭바 + 그리드 전체에 적용
                    .animation(.easeInOut(duration: 0.25), value: tabGroupOffset)
                }
            }
            .coordinateSpace(name: "scroll")

            // 🔹 배너 위에 표시될 브랜드 정보 (로고 + 이름 + 설명)
            BrandOverlayInfoView()
                .padding(.top, 40) // SafeArea 고려
        }
        .environmentObject(viewModel)
    }

    // ✅ 스크롤 offset에 따라 탭바와 아이템 블럭 전체를 아래로 이동
    var tabGroupOffset: CGFloat {
        let offset = viewModel.scrollOffset
        return offset > 0 ? min(offset, 100) : 0
    }
}

#Preview {
    BrandPage()
}
