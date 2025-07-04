import SwiftUI

struct BrandPage: View {
    @StateObject private var viewModel = BrandPageViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.BgColor.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
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
                    .offset(x: +15)
                    .offset(y: overlayOffset + 250)
                    .animation(.easeInOut(duration: 0.25), value: overlayOffset)
                    .padding(.top, -viewModel.bannerHeight + 40)
                    
                    VStack(spacing: 0) {
                        Rectangle()
                            .fill(Color.BgColor)
                            .frame(height: 30)
                        
                        CategoryTabBarView(
                            selected: $viewModel.selectedCategory
                        )
                        .padding(.top, 12)
                        .padding(.bottom, 12)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color.BgColor)
                        
                        ItemGridView()
                            .padding(.bottom, 50)
                        
                        Text("Fashions fade, style is eternal. \n – Yves Saint Laurent")
                            .font(.system(size: 12))
                            .foregroundColor(Color.TabPurple)
                            .multilineTextAlignment(.center)
                        
                        Spacer(minLength: 200)
                    }
                    .offset(y: tabGroupOffset) // 🔧 여기에 적용
                    .animation(.easeInOut(duration: 0.25), value: tabGroupOffset)
                }
            }
            .coordinateSpace(name: "scroll")
            
            TopTabBarView(
                tabBarScrollOffset: viewModel.tabBarScrollOffset,
                brandName: "브랜드이름",
                backAction: {
                    print("뒤로가기 탭됨")
                }
            )
            .offset(y: -85)
            .zIndex(1000)
            
//            VStack(alignment: .leading, spacing: 4) {
//                Text("🟦 scrollOffset: \(Int(viewModel.scrollOffset))")
//                Text("🟥 categoryTabBarScrollOffset: \(Int(viewModel.categoryTabBarScrollOffset))")
//                Text("📦 categoryTabBarScrollOffset: \(Int(viewModel.categoryTabBarScrollOffset))")
//            }
//            .font(.system(size: 13, weight: .semibold))
//            .foregroundColor(.white)
//            .padding(10)
//            .background(Color.blue.opacity(0.85))
//            .cornerRadius(12)
//            .padding(.top, 60)
//            .padding(.horizontal)
//            .zIndex(999)
        }
        .environmentObject(viewModel)
    }
    
    // ✅ 여기에 필요한 computed properties 추가
    var overlayOffset: CGFloat {
        min(viewModel.scrollOffset, 170)
    }
    
    var tabGroupOffset: CGFloat {
        min(viewModel.scrollOffset, 170)
    }

    var tabBarOffset: CGFloat {
        if viewModel.categoryTabBarScrollOffset <= 300 {
            return viewModel.categoryTabBarScrollOffset
        } else if viewModel.categoryTabBarScrollOffset <= 665 {
            return 600 - (665 - viewModel.categoryTabBarScrollOffset)
        } else {
            return 600
        }
    }
}

#Preview {
    BrandPage()
}
