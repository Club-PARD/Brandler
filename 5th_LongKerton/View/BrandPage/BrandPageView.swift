import SwiftUI

struct BrandPage: View {
    let brandId: Int
    @State private var brandInfo: BrandInfo?
    @State private var productList: [Product1] = []
    
    @StateObject private var viewModel = BrandViewModel()
    @StateObject private var getViewModel = GetBrandListViewModel()
    @State private var scrollProxy: ScrollViewProxy? = nil
    @Environment(\.dismiss) var dismiss
    @State private var descriptionTextHeight: CGFloat = 0

    @EnvironmentObject var session: UserSessionManager
    @State private var isScraped: Bool = false
    @Environment(\.scenePhase) private var scenePhase
    // ✅ 일반 인스턴스로 생성
    private let scrapeAPI = ScrapeServerAPI()

    var body: some View {
        ZStack(alignment: .top) {
            Color.BgColor.ignoresSafeArea()

            if let brandInfo = brandInfo {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 0) {
                            Color.clear.frame(height: 0).id("top")
                            GeometryReader { geo in
                                BrandBannerView(brand: brandInfo)
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

                            BrandInfoOverlayView(
                                scrollOffset: viewModel.scrollOffset,
                                bannerHeight: viewModel.bannerHeight,
                                brand: brandInfo,
                                brandId: brandInfo.id,
                                isScraped: $isScraped,
                                onDescriptionHeightChange: { height in
                                    descriptionTextHeight = height
                                }
                            )
                            .offset(x: 10, y: overlayOffset + 250)
                            .padding(.top, -viewModel.bannerHeight + 40)
                            .animation(.easeInOut(duration: 0.25), value: overlayOffset)
                            .padding(.bottom, 15)

                            VStack(spacing: 0) {
                                CategoryTabBarView(selected: $viewModel.selectedCategory)
                                    .padding(.vertical, 12)
                                    .frame(height: 30)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.BgColor)
                                    .padding(.horizontal, 15)

                                ItemGridView()
                                    .padding(.bottom, 50)
                                    .padding(.horizontal, 10)

                                Text("Fashions fade, style is eternal. \n – Yves Saint Laurent")
                                    .font(.custom("Pretendard-Regular", size: 12))
                                    .foregroundColor(Color.TabPurple)
                                    .multilineTextAlignment(.center)

                                Spacer(minLength: 200)
                            }
                            .offset(y: tabGroupOffset + descriptionTextHeight - 38)
                            .animation(.easeInOut(duration: 0.25), value: descriptionTextHeight)
                            .animation(.easeInOut(duration: 0.25), value: tabGroupOffset)
                        }
                    }
                    .coordinateSpace(name: "scroll")
                    .onAppear {
                        scrollProxy = proxy
                    }
                }

                TopTabBarView(
                    tabBarScrollOffset: viewModel.tabBarScrollOffset,
                    brandName: brandInfo.brandName
                )
                .offset(y: -10)
                .zIndex(1000)

                ScrollToTopButton(
                    proxy: scrollProxy,
                    visible: viewModel.scrollOffset > 200
                )
                .offset(y: -70)
            } else {
                ProgressView("브랜드 정보를 불러오는 중...")
                    .foregroundColor(.gray)
            }
        }
        .environmentObject(viewModel)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(edges: .top)
        .onAppear {
            Task {
                if let email = session.userData?.email {
                    do {
                        let fetched = try await getViewModel.getBrandInfo(email, brandId)
                        self.brandInfo = fetched
                        
                        let productList = try await getViewModel.getProductInfo(brandId)
                        scrapeAPI.fetchIsScraped(email: email, brandId: brandId) { result in
                            DispatchQueue.main.async {
                                self.isScraped = result ?? false
                            }
                        }
                    } catch {
                        print("❌ 브랜드 정보 로딩 실패: \(error)")
                    }
                }
            }
        }
        .onDisappear {
            if let email = session.userData?.email,
               let brandInfo = brandInfo {
                scrapeAPI.patchLike(email: email, brandId: brandInfo.id, isScraped: isScraped)
            }
        }
        .onChange(of: scenePhase) { _, new in
            if new == .background || new == .inactive {
                if let email = session.userData?.email,
                   let brandInfo = brandInfo {
                    scrapeAPI.patchLike(email: email, brandId: brandInfo.id, isScraped: isScraped)
                }
            }
        }
    }

    var overlayOffset: CGFloat {
        min(viewModel.scrollOffset, 170)
    }

    var tabGroupOffset: CGFloat {
        min(viewModel.scrollOffset, 170)
    }
}

// MARK: - 프리뷰용 Brand 샘플
extension Brand {
    static let preview: Brand = Brand(
        id: 1,
        name: "샘플 브랜드",
        brandGenre: "캐주얼",
        description: "좋은 코드 구성이고, 거의 다 구현이 되어 있습니다. 문제는 지금 BrandInfoOverlayView의 높이가 즉시 계산되지 않아서 발생하는 것으로 보입니다. SwiftUI의 GeometryReader와 .preference(...)는 레이아웃 사이클 후에 높이 정보를 전달하기 때문에, overlayHeight 값이 즉시 반영되지 않는 경우가 있습니다.",
        brandBannerUrl: "mockBanner1",
        brandLogoUrl: "mockLogo1",
        brandHomePageUrl: "https://www.samplebrand.com",
        brandLevel: 3
    )
}

// MARK: - BrandPage 프리뷰
//#Preview {
//    BrandPage(brand: .preview)
//        .environmentObject(UserSessionManager.shared)
//}
