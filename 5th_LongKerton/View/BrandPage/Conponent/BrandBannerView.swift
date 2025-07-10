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

