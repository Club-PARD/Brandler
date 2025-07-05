import SwiftUI

struct BrandPage: View {
    @StateObject private var viewModel = BrandPageViewModel()
    @State private var scrollProxy: ScrollViewProxy? = nil
    var brand: MockBrand
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.BgColor.ignoresSafeArea()
            
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 0) {
                        Color.clear.frame(height: 0).id("top")
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
                        
                        BrandInfoOverlayView(
                            scrollOffset: viewModel.scrollOffset,
                            bannerHeight: viewModel.bannerHeight
                        )
                        .offset(x: 15, y: overlayOffset + 250)
                        .padding(.top, -viewModel.bannerHeight + 40)
                        .animation(.easeInOut(duration: 0.25), value: overlayOffset)
                        
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
            
            // ⬆️ 탑탭바
            TopTabBarView(
                tabBarScrollOffset: viewModel.tabBarScrollOffset,
                brandName: "브랜드이름",
                backAction: {
                    print("뒤로가기 탭됨") }
            )
            .offset(y: -85)
            .zIndex(1000)
            
            // ⬆️ 최상단 오버레이 버튼
            ScrollToTopButton(
                proxy: scrollProxy,
                visible: viewModel.scrollOffset > 200
            )
            .offset(y: -70)
        }
        .environmentObject(viewModel)
        .navigationBarBackButtonHidden(true)
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
//#Preview {
//    BrandPage()
//}
