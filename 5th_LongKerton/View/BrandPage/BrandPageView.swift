import SwiftUI

struct BrandPage: View {
    @StateObject private var viewModel = BrandViewModel()
    @State private var scrollProxy: ScrollViewProxy? = nil

    var brand: Brand

    var body: some View {
        ZStack(alignment: .top) {
            Color.BgColor.ignoresSafeArea()

            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 0) {
                        Color.clear.frame(height: 0).id("top")

                        // 🧭 배너 + 오프셋 추적
                        GeometryReader { geo in
                            BrandBannerView(brand: brand)
                                .frame(height: viewModel.bannerHeight)
                                .background(
                                    Color.clear
                                        .preference(
                                            key: ScrollOffsetKey.self,
                                            value: -geo.frame(in: .named("scroll")).minY
                                        )
                                )
                        }
                        .frame(height: viewModel.bannerHeight)

                        // 🧩 변경 감지: scrollOffset 업데이트
                        .onPreferenceChange(ScrollOffsetKey.self) { offset in
                            viewModel.updateScrollOffset(offset)
                        }

                        // 🔹 브랜드 오버레이
                        BrandInfoOverlayView(
                            scrollOffset: viewModel.scrollOffset,
                            bannerHeight: viewModel.bannerHeight,
                            brand: brand
                        )
                        .offset(x: 15, y: overlayOffset + 250)
                        .padding(.top, -viewModel.bannerHeight + 40)
                        .animation(.easeInOut(duration: 0.25), value: overlayOffset)

                        // 🔹 콘텐츠 뷰
                        VStack(spacing: 0) {
                            Rectangle().fill(Color.BgColor).frame(height: 30)

                            CategoryTabBarView(selected: $viewModel.selectedCategory)
                                .padding(.vertical, 12)
                                .frame(height: 60)
                                .frame(maxWidth: .infinity)
                                .background(Color.BgColor)

                            ItemGridView().padding(.bottom, 50)

                            Text("Fashions fade, style is eternal. \n – Yves Saint Laurent")
                                .font(.system(size: 12))
                                .foregroundColor(Color.TabPurple)
                                .multilineTextAlignment(.center)

                            Spacer(minLength: 200)
                        }
                        .offset(y: tabGroupOffset)
                        .animation(.easeInOut(duration: 0.25), value: tabGroupOffset)
                    }
                }
                .coordinateSpace(name: "scroll")
                .onAppear { scrollProxy = proxy }
            }

            // 🔹 상단 탭바
            TopTabBarView(
                tabBarScrollOffset: viewModel.tabBarScrollOffset,
                brandName: brand.name,
                backAction: {
                    print("뒤로가기 탭됨")
                }
            )
            .offset(y: -85)
            .zIndex(1000)

            // 🔹 스크롤 탑 버튼
            ScrollToTopButton(
                proxy: scrollProxy,
                visible: viewModel.scrollOffset > 200
            )
            .offset(y: -70)
        }
        .environmentObject(viewModel)
        .navigationBarBackButtonHidden(true)
    }

    // 🔸 오버레이/탭바 위치 계산
    var overlayOffset: CGFloat {
        min(viewModel.scrollOffset, 170)
    }

    var tabGroupOffset: CGFloat {
        min(viewModel.scrollOffset, 170)
    }

    var tabBarOffset: CGFloat {
        let offset = viewModel.categoryTabBarScrollOffset
        if offset <= 300 {
            return offset
        } else if offset <= 665 {
            return 600 - (665 - offset)
        } else {
            return 600
        }
    }
}

#Preview {
    NavigationView {
        BrandPage(brand: Brand(
            id: UUID(),
            name: "테스트 브랜드",
            brandGenre: "스트릿",
            description: "이것은 브랜드 설명입니다.",
            brandBannerUrl: "mockBanner1",
            brandLogoUrl: "mockLogo1",
            brandHomePageUrl: "https://example.com",
            brandLevel: 1
        ))
    }
}
