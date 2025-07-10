import SwiftUI

struct BrandPage: View {
    let brandId: Int
    @State private var brandInfo: BrandInfo?
    @State private var productList: [Product] = []

    @StateObject private var viewModel = BrandViewModel()
    @StateObject private var getViewModel = GetBrandListViewModel()
    @State private var scrollProxy: ScrollViewProxy? = nil
    @Environment(\.dismiss) var dismiss

    @State private var descriptionTextHeight: CGFloat = 0
    @State private var titleTextHeight: CGFloat = 0

    @EnvironmentObject var session: UserSessionManager
    @State private var isScraped: Bool = false
    @Environment(\.scenePhase) private var scenePhase
    private let scrapeAPI = ScrapeServerAPI()

    // 브랜드 이름이 2줄 이상인지 판단 (35pt * 2 + 여백)
    var isTitleMultiLine: Bool {
        titleTextHeight > 80
    }

    var overlayOffset: CGFloat {
        min(viewModel.scrollOffset, 170)
    }

    var tabGroupOffset: CGFloat {
        min(viewModel.scrollOffset, 170)
    }

    var tabGroupYOffset: CGFloat {
        if isTitleMultiLine {
            return tabGroupOffset + descriptionTextHeight + titleTextHeight - 45
        } else {
            return tabGroupOffset + descriptionTextHeight
        }
    }

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
                                    .frame(width: UIScreen.main.bounds.width + 10, height: viewModel.bannerHeight)
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
                                },
                                onTitleHeightChange: { height in
                                    titleTextHeight = height 
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

                                ItemGridView(items: productList)
                                    .padding(.bottom, 50)
                                    .padding(.horizontal, 10)

                                Text("Fashions fade, style is eternal. \n – Yves Saint Laurent")
                                    .font(.custom("Pretendard-Regular", size: 12))
                                    .foregroundColor(Color.TabPurple)
                                    .multilineTextAlignment(.center)

                                Spacer(minLength: 200)
                            }
                            .offset(y: tabGroupYOffset - 38)
                            .animation(.easeInOut(duration: 0.25), value: descriptionTextHeight)
                            .animation(.easeInOut(duration: 0.25), value: tabGroupOffset)
                            .animation(.easeInOut(duration: 0.25), value: titleTextHeight)
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

                        let products = try await getViewModel.getProductInfo(brandId)
                        self.productList = products

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
}
