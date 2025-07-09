//
//import SwiftUI
//
//struct BrandPage: View {
//    @StateObject private var viewModel = BrandViewModel()
//    @State private var scrollProxy: ScrollViewProxy? = nil
//
//    var brand: Brand
//
//    @State private var descriptionTextHeight: CGFloat = 0
//    @StateObject private var scrapeAPI: ScrapeServerAPI
//    @EnvironmentObject var session: UserSessionManager
//    @State private var isScraped: Bool = false
//
//    init(brand: Brand) {
//        self.brand = brand
//        _scrapeAPI = StateObject(wrappedValue: ScrapeServerAPI(brand: brand))
//    }
//
//    var body: some View {
//        ZStack(alignment: .top) {
//            Color.BgColor.ignoresSafeArea()
//
//            ScrollViewReader { proxy in
//                ScrollView {
//                    VStack(spacing: 0) {
//                        Color.clear.frame(height: 0).id("top")
//
//                        GeometryReader { geo in
//                            BrandBannerView(brand: brand)
//                                .frame(height: viewModel.bannerHeight)
//                                .background(
//                                    Color.clear.preference(
//                                        key: ScrollOffsetKey.self,
//                                        value: -geo.frame(in: .named("scroll")).minY
//                                    )
//                                )
//                        }
//                        .frame(height: viewModel.bannerHeight)
//                        .onPreferenceChange(ScrollOffsetKey.self) { offset in
//                            viewModel.updateScrollOffset(offset)
//                        }
//
//                        BrandInfoOverlayView(
//                            scrollOffset: viewModel.scrollOffset,
//                            bannerHeight: viewModel.bannerHeight,
//                            brand: brand,
//                            brandId: brand.id,
//                            isScraped: isScraped,
//                            onDescriptionHeightChange: { height in
//                                descriptionTextHeight = height
//                            }
//                        )
//                        .offset(x: 15, y: overlayOffset + 250)
//                        .padding(.top, -viewModel.bannerHeight + 40)
//                        .animation(.easeInOut(duration: 0.25), value: overlayOffset)
//                        .padding(.bottom, 15)
//
//                        VStack(spacing: 0) {
//                            CategoryTabBarView(selected: $viewModel.selectedCategory)
//                                .padding(.vertical, 12)
//                                .frame(height: 30)
//                                .frame(maxWidth: .infinity)
//                                .background(Color.BgColor)
//
//                            ItemGridView().padding(.bottom, 50)
//
//                            Text("Fashions fade, style is eternal. \n – Yves Saint Laurent")
//                                .font(.custom("Pretendard-Regular", size: 12))
//                                .foregroundColor(Color.TabPurple)
//                                .multilineTextAlignment(.center)
//
//                            Spacer(minLength: 200)
//                        }
//                        .offset(y: tabGroupOffset + descriptionTextHeight - 38)
//                        .animation(.easeInOut(duration: 0.25), value: descriptionTextHeight)
//                        .animation(.easeInOut(duration: 0.25), value: tabGroupOffset)
//                    }
//                }
//                .coordinateSpace(name: "scroll")
//                .onAppear { scrollProxy = proxy }
//            }
//
//            TopTabBarView(
//                tabBarScrollOffset: viewModel.tabBarScrollOffset,
//                brandName: brand.name,
//                backAction: {
//                    print("뒤로가기 탭됨")
//                }
//            )
//            .offset(y: -85)
//            .zIndex(1000)
//
//            ScrollToTopButton(
//                proxy: scrollProxy,
//                visible: viewModel.scrollOffset > 200
//            )
//            .offset(y: -70)
//        }
//        .environmentObject(viewModel)
//        .navigationBarBackButtonHidden(true)
//        .ignoresSafeArea(edges: .top)
//        .onAppear {
//            // ⭐️ 서버에서 좋아요 상태 GET
//            if let email = session.userData?.email {
//                scrapeAPI.fetchIsScraped(email: email, brandId: brand.id) { result in
//                    DispatchQueue.main.async {
//                        if let isScraped = result {
//                            self.isScraped = isScraped
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//    var overlayOffset: CGFloat {
//        min(viewModel.scrollOffset, 170)
//    }
//
//    var tabGroupOffset: CGFloat {
//        min(viewModel.scrollOffset, 170)
//    }
//}

import SwiftUI

struct BrandPage: View {
    @StateObject private var viewModel = BrandViewModel()
    @State private var scrollProxy: ScrollViewProxy? = nil
    @Environment(\.dismiss) var dismiss
    var brand: Brand

    @State private var descriptionTextHeight: CGFloat = 0
    @StateObject private var scrapeAPI: ScrapeServerAPI
    @EnvironmentObject var session: UserSessionManager
    @State private var isScraped: Bool = false

    init(brand: Brand) {
        self.brand = brand
        _scrapeAPI = StateObject(wrappedValue: ScrapeServerAPI(brand: brand))
    }

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

                        // ⭐️ isScraped를 @Binding으로 전달
                        BrandInfoOverlayView(
                            scrollOffset: viewModel.scrollOffset,
                            bannerHeight: viewModel.bannerHeight,
                            brand: brand,
                            brandId: brand.id,
                            isScraped: $isScraped,
                            onDescriptionHeightChange: { height in
                                descriptionTextHeight = height
                            }
                        )
                        .offset(x: 15, y: overlayOffset + 250)
                        .padding(.top, -viewModel.bannerHeight + 40)
                        .animation(.easeInOut(duration: 0.25), value: overlayOffset)
                        .padding(.bottom, 15)

                        VStack(spacing: 0) {
                            CategoryTabBarView(selected: $viewModel.selectedCategory)
                                .padding(.vertical, 12)
                                .frame(height: 30)
                                .frame(maxWidth: .infinity)
                                .background(Color.BgColor)

                            ItemGridView().padding(.bottom, 50)

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
        .onAppear {
            // ⭐️ 서버에서 좋아요 상태 GET
            if let email = session.userData?.email {
                scrapeAPI.fetchIsScraped(email: email, brandId: brand.id) { result in
                    DispatchQueue.main.async {
                        if let isScraped = result {
                            self.isScraped = isScraped
                        }
                    }
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
