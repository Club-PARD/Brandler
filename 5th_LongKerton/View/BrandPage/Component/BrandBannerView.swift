import SwiftUI

struct BrandBannerView: View {
    @EnvironmentObject var viewModel: BrandPageViewModel
    let brand: MockBrand  // 브랜드 모델 받기

    var body: some View {
        GeometryReader { geo in
            ZStack {
                let holeWidth = viewModel.holeSize.width
                let holeHeight = viewModel.holeSize.height
                let offsetX = -geo.size.width / 2 + 61 + holeWidth / 2 - 75
                let offsetY = viewModel.offsetYForScroll

                // 선명한 이미지
                Image(brand.bannerImageName)  // ✅ 모델에서 이미지 사용
                    .resizable()
                    .scaledToFill()
                    .frame(height: viewModel.bannerHeight)
                    .clipped()

                // 블러 이미지 + 마스크
                Image(brand.bannerImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: viewModel.blurredBannerHeight)
                    .offset(y: -(viewModel.blurredBannerHeight - viewModel.bannerHeight) / 2)
                    .blur(radius: 10)
                    .mask(
                        Rectangle()
                            .overlay(
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

                // 외곽선
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
    struct PreviewWrapper: View {
        @StateObject private var viewModel = BrandPageViewModel()
        @State private var sliderValue: CGFloat = 0
        let sampleBrand = MockBrand.sampleData.first! // ✅ 샘플 브랜드 하나 가져오기

        var body: some View {
            VStack {
                BrandBannerView(brand: sampleBrand)
                    .environmentObject(viewModel)

                Slider(value: $sliderValue, in: 0...300) {
                    Text("Scroll Offset")
                }
                .padding()
                .onChange(of: sliderValue) { newValue in
                    viewModel.updateScrollOffset(newValue)
                }

                Text("scrollOffset: \(Int(sliderValue)) / angle: \(Int(viewModel.angleForScroll.degrees))°")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .background(Color.black)
        }
    }

    return PreviewWrapper()
}
