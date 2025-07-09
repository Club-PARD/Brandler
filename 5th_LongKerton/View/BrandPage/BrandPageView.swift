import SwiftUI

// 브랜드 상세 페이지 뷰
struct BrandPage: View {
    @StateObject private var viewModel = BrandViewModel()
    @State private var scrollProxy: ScrollViewProxy? = nil

    var brand: Brand

    @State private var descriptionTextHeight: CGFloat = 0  // ① 높이 상태 추가

    var body: some View {
        ZStack(alignment: .top) {
            Color.BgColor.ignoresSafeArea()

            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 0) {
                        Color.clear.frame(height: 0).id("top")

                        GeometryReader { geo in
                            BrandBannerView(brand: brand)
                                .frame(height: viewModel.bannerHeight)
                                .background(
                                    Color.clear.preference(
                                        key: ScrollOffsetKey.self,
                                        value: -geo.frame(in: .named("scroll")).minY
                                    )
                                )
                        }
                        .frame(height: viewModel.bannerHeight)
                        .onPreferenceChange(ScrollOffsetKey.self) { offset in
                            viewModel.updateScrollOffset(offset)
                        }
//                        .offset(x: 20)
                        // ② BrandInfoOverlayView 에 콜백 전달
                        BrandInfoOverlayView(
                            scrollOffset: viewModel.scrollOffset,
                            bannerHeight: viewModel.bannerHeight,
                            brand: brand,
                            onDescriptionHeightChange: { height in
                                descriptionTextHeight = height
                            }
                        )
                        .offset(x: 10,y: overlayOffset + 250)
                        .padding(.top, -viewModel.bannerHeight + 40)
                        .animation(.easeInOut(duration: 0.25), value: overlayOffset)
                        .padding(.bottom, 15)
//                        .padding(.horizontal, 20)

                        VStack(spacing: 0) {


                            CategoryTabBarView(selected: $viewModel.selectedCategory)
                                .padding(.vertical, 12)
                                .frame(height: 30)
                                .frame(maxWidth: .infinity)
                                .background(Color.BgColor)
                                .padding(.horizontal, 15)

                            ItemGridView().padding(.bottom, 50).padding(.horizontal, 10)

                            Text("Fashions fade, style is eternal. \n – Yves Saint Laurent")
                                .font(.custom("Pretendard-Regular", size: 12))
                                .foregroundColor(Color.TabPurple)
                                .multilineTextAlignment(.center)

                            Spacer(minLength: 200)
                        }
                        // ③ descriptionTextHeight 를 offset에 더해서 반영
                        .offset(y: tabGroupOffset + descriptionTextHeight - 38)
                        .animation(.easeInOut(duration: 0.25), value: descriptionTextHeight)
                        .animation(.easeInOut(duration: 0.25), value: tabGroupOffset)
//                        .border(Color.red, width: 1)
                    }
                }
                .coordinateSpace(name: "scroll")
                .onAppear { scrollProxy = proxy }
            }

            TopTabBarView(
                tabBarScrollOffset: viewModel.tabBarScrollOffset,
                brandName: brand.name,
                backAction: {
                    print("뒤로가기 탭됨")
                }
            )
            .offset(y: -85)
            .zIndex(1000)

            ScrollToTopButton(
                proxy: scrollProxy,
                visible: viewModel.scrollOffset > 200
            )
            .offset(y: -70)
        }
        .environmentObject(viewModel)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .top)
//        .padding(.horizontal, 25)
    }

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
// MARK: - 프리뷰용 Brand 샘플
extension Brand {
    static let preview: Brand = Brand(
        id: UUID(),
        name: "샘플 브랜드",
        brandGenre: "캐주얼",
        description: "좋은 코드 구성이고, 거의 다 구현이 되어 있습니다. 문제는 지금 BrandInfoOverlayView의 높이가 즉시 계산되지 않아서 발생하는 것으로 보입니다. SwiftUI의 GeometryReader와 .preference(...)는 레이아웃 사이클 후에 높이 정보를 전달하기 때문에, overlayHeight 값이 즉시 반영되지 않는 경우가 있습니다.",
        brandBannerUrl: "mockBanner1",
        brandLogoUrl: "mockLogo1",
        //        isScraped: true,
        brandHomePageUrl: "https://www.samplebrand.com",
        brandLevel: 3
    )
}

// MARK: - BrandPage 프리뷰
#Preview {
    BrandPage(brand: .preview)
}
