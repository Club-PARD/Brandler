import SwiftUI

struct ContentView: View {
    @State private var scrollOffset: CGFloat = 0
    @State private var lastOffset: CGFloat = 0

    let bannerHeight: CGFloat = 500
    let blurredBannerHeight: CGFloat = 700

    var body: some View {
        ZStack(alignment: .top) {
            Color.black
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 0) {
                    // 🛰 스크롤 위치 감지
                    GeometryReader { geo in
                        let offset = geo.frame(in: .named("scroll")).minY
                        Color.clear
                            .preference(key: ScrollOffsetKey.self, value: offset)
                    }
                    .frame(height: 0)

                    // 🎞 배너 & 구멍 마스크
                    ZStack {
                        Image("brandBanner")
                            .resizable()
                            .scaledToFill()
                            .frame(height: bannerHeight)
                            .clipped()

                        Image("brandBanner")
                            .resizable()
                            .scaledToFill()
                            .frame(height: blurredBannerHeight)
                            .offset(y: -(blurredBannerHeight - bannerHeight) / 2)
                            .blur(radius: 10)
                            .mask(
                                RotatingRectHole(
                                    angle: angleForScroll(scrollOffset),
                                    offsetX: -70,
                                    offsetY: offsetYForScroll(scrollOffset) - 30,
                                    holeWidth: 131,
                                    holeHeight: 413
                                )
                                .fill(style: FillStyle(eoFill: true))
                            )
                    }
                    .frame(height: bannerHeight)
                    .clipped()

                    // ✨ 자유 콘텐츠
                    VStack(spacing: 30) {
                        Text("자유 디자인 콘텐츠")
                            .font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.white)

                        Rectangle()
                            .fill(Color.blue)
                            .frame(height: 200)
                            .cornerRadius(20)

                        Rectangle()
                            .fill(Color.green.opacity(0.5))
                            .frame(height: 300)
                            .cornerRadius(20)
                    }
                    .padding(.horizontal)
                    .padding(.top, 30)

                    Spacer(minLength: 500) // 스크롤 확보
                }
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(ScrollOffsetKey.self) { value in
                let offset = -value
                scrollOffset = offset
            }
        }
        
    }

    func angleForScroll(_ offset: CGFloat) -> Angle {
        let clamped = min(max(offset, 0), 300)
        let progress = clamped / 300
        return .degrees(90 * progress)
    }

    func offsetYForScroll(_ offset: CGFloat) -> CGFloat {
        let progress = min(max(offset / 300, 0), 1)
        return -50 * progress
    }
}

#Preview {
    ContentView()
}
