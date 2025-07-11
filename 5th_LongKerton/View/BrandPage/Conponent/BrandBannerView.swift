import SwiftUI

struct BrandBannerView: View {
    @StateObject var viewModel: BrandViewModel
    let brand: BrandInfo

    var body: some View {
        ZStack {
            let holeWidth = viewModel.holeSize.width
            let holeHeight = viewModel.holeSize.height

            // ✅ 고정된 X 위치 (브랜드에 영향 없음)
            let offsetX: CGFloat = UIScreen.main.bounds.width / 2 - 280
            let offsetY: CGFloat = viewModel.bannerHeight - 550

            Image(brand.brandBanner)
                .resizable()
                .scaledToFill()
                .frame(height: viewModel.bannerHeight)
                .clipped()

            Image(brand.brandBanner)
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
                            offsetY: offsetY,
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
                offsetY: offsetY,
                holeWidth: holeWidth,
                holeHeight: holeHeight
            )
            .stroke(Color.white.opacity(0.5), lineWidth: 1)
        }
        .frame(height: viewModel.bannerHeight)
        .clipped()
    }
}
