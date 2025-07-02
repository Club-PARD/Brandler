import SwiftUI

struct BrandBannerView: View {
    @EnvironmentObject var viewModel: BrandPageViewModel

    var body: some View {
        GeometryReader { geo in
            ZStack {
                let holeWidth = viewModel.holeSize.width
                let holeHeight = viewModel.holeSize.height

                // ContentView 방식으로 위치 계산
                let offsetX = -geo.size.width / 2 + 61 + holeWidth / 2 - 75
                let offsetY = viewModel.offsetYForScroll

                // 1️⃣ 아래에 선명한 이미지
                Image("brandBanner")
                    .resizable()
                    .scaledToFill()
                    .frame(height: viewModel.bannerHeight)
                    .clipped()

                // 2️⃣ 블러 이미지에 '구멍 마스크' 적용
                Image("brandBanner")
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
                                .blendMode(.destinationOut) // 구멍 뚫기
                            )
                            .compositingGroup() // 필수!
                    )

                // 3️⃣ 회전 사각형 stroke (외곽선)
                RotatingRectHole(
                    angle: viewModel.angleForScroll,
                    offsetX: offsetX,
                    offsetY: offsetY - 30,
                    holeWidth: holeWidth,
                    holeHeight: holeHeight
                )
                .stroke(Color.blue.opacity(0.6), lineWidth: 2)
                .animation(.easeInOut(duration: 0.3), value: viewModel.angleForScroll)

//                // 4️⃣ 로고 위치 (구멍 안에 배치)
//                let logoX = geo.size.width / 2 + offsetX - holeWidth / 2 + 65
//                let logoY = geo.size.height / 2 + offsetY + holeHeight * 0.34 - 30
//
//                Image("brandLogo")
//                    .resizable()
//                    .frame(width: 60, height: 60)
//                    .clipShape(Circle())
//                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
//                    .position(x: logoX, y: logoY)
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

        var body: some View {
            VStack {
                BrandBannerView()
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
