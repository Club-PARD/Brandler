import SwiftUI

struct BrandOverlayInfoView: View {
    @EnvironmentObject var viewModel: BrandPageViewModel

    var body: some View {
        GeometryReader { geo in
            let holeWidth = viewModel.holeSize.width
            let holeHeight = viewModel.holeSize.height

            // ✅ ContentView 방식과 동일한 offset 계산
            let offsetX = -geo.size.width / 2 + 61 + holeWidth / 2
            let offsetY = viewModel.offsetYForScroll - 180

            // ⬇️ 왼쪽 아래로부터 1/4 지점
            let brandX = geo.size.width / 2 + offsetX - holeWidth / 2
            let brandY = geo.size.height / 2 + offsetY + holeHeight * 0.75

            // 색상 보간 (스크롤 시 밝은색 → 어두운색 전환)
            let scrollProgress = min(max(viewModel.scrollOffset / 300, 0), 1)
            let interpolatedColor = Color.interpolateHex(from: "#FFFFFF", to: "#888888", fraction: scrollProgress)

            VStack(spacing: 6) {
                Image("brandLogo")
                    .resizable()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))

                Text("브랜드이름")
                    .font(.headline)
                    .foregroundColor(interpolatedColor)

                Text("힙하고 유니크한 감성을 담은 브랜드입니다.")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundColor(interpolatedColor)
            }
            .position(x: brandX, y: brandY)
        }
        .frame(height: viewModel.bannerHeight)
    }
}
#Preview {
    struct PreviewWrapper: View {
        @StateObject private var viewModel = BrandPageViewModel()

        var body: some View {
            ZStack {
                // 🎞 실제 배너 이미지
                BrandBannerView()
                    .environmentObject(viewModel)

                // ⬆️ 오버레이 텍스트/로고
                BrandOverlayInfoView()
                    .environmentObject(viewModel)
            }
            .frame(height: viewModel.bannerHeight)
        }
    }

    return PreviewWrapper()
}
