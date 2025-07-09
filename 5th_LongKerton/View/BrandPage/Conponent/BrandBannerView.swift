import SwiftUI

struct BrandBannerView: View {
    @EnvironmentObject var viewModel: BrandViewModel
    let brand: BrandInfo

    var body: some View {
        GeometryReader { geo in
            ZStack {
                let holeWidth = viewModel.holeSize.width
                let holeHeight = viewModel.holeSize.height
                let nameWidthAdjustment = min(max(viewModel.brandNameWidth - 220, 0), 60)
                let offsetX = -geo.size.width / 2 + 61 + holeWidth / 2 - 75 - nameWidthAdjustment / 2
                let offsetY = viewModel.offsetYForScroll

                Image(brand.brandBannerUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(height: viewModel.bannerHeight)
                    .clipped()

                Image(brand.brandBannerUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(height: viewModel.blurredBannerHeight)
                    .offset(y: -(viewModel.blurredBannerHeight - viewModel.bannerHeight) / 2)
                    .blur(radius: 10)
                    .mask(
                        Rectangle().overlay(
                            RotatingRectHole(
                                angle: viewModel.angleForScroll,
                                offsetX: offsetX,
                                offsetY: offsetY - 30,
                                holeWidth: holeWidth,
                                holeHeight: holeHeight
                            )
                            .blendMode(.destinationOut)
                        )
                        .compositingGroup()
                    )

                LinearGradient(
                    gradient: Gradient(colors: [Color.BgColor.opacity(0), Color.BgColor.opacity(1)]),
                    startPoint: .top, endPoint: .bottom
                )
                .frame(height: viewModel.bannerHeight)

                RotatingRectHole(
                    angle: viewModel.angleForScroll,
                    offsetX: offsetX,
                    offsetY: offsetY - 30,
                    holeWidth: holeWidth,
                    holeHeight: holeHeight
                )
                .stroke(Color.white.opacity(0.5), lineWidth: 2)
            }
            .frame(height: viewModel.bannerHeight)
            .clipped()
        }
    }
}

#Preview {
    let mockBrand = Brand(
        id: 1, // Int 타입
        name: "프리뷰 브랜드",
        brandGenre: "모던",
        description: "강렬한 컬러로 존재감을 드러내는 브랜드입니다.",
        brandBannerUrl: "brandBanner",
        brandLogoUrl: "brandLogo",
        brandHomePageUrl: "https://www.example.com",
        brandLevel: 2
    )

    let mockViewModel = BrandViewModel()
    mockViewModel.scrollOffset = 50
    mockViewModel.updateScrollOffset(50)

    return ZStack {
        Color.black.ignoresSafeArea()
        BrandBannerView(brand: mockBrand)
            .environmentObject(mockViewModel)
    }
    .frame(height: 300)
}
