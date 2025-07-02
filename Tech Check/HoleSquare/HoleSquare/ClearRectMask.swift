import SwiftUI

/// 🔳 스크롤에 따라 회전·이동·크기 변화하는 사각형 구멍 Shape
struct RotatingRectHole: Shape {
    var angle: Angle
    var offsetX: CGFloat
    var offsetY: CGFloat
    var holeWidth: CGFloat
    var holeHeight: CGFloat

    var animatableData: AnimatablePair<
        AnimatablePair<
            AnimatablePair<Double, CGFloat>, CGFloat
        >,
        AnimatablePair<CGFloat, CGFloat>
    > {
        get {
            AnimatablePair(
                AnimatablePair(
                    AnimatablePair(angle.degrees, offsetX),
                    offsetY
                ),
                AnimatablePair(holeWidth, holeHeight)
            )
        }
        set {
            angle = .degrees(newValue.first.first.first)
            offsetX = newValue.first.first.second
            offsetY = newValue.first.second
            holeWidth = newValue.second.first
            holeHeight = newValue.second.second
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRect(rect)

        let holeSize = CGSize(width: holeWidth, height: holeHeight)

        let center = CGPoint(
            x: rect.minX + 61 + offsetX,
            y: rect.midY + offsetY
        )

        let holeRect = CGRect(
            x: center.x - holeSize.width / 2,
            y: center.y - holeSize.height / 2,
            width: holeSize.width,
            height: holeSize.height
        )

        let anchor = CGPoint(
            x: holeRect.minX,
            y: holeRect.maxY - holeRect.height * 0.16 // 아래에서 1/4 지점
        )

        let transform = CGAffineTransform(translationX: anchor.x, y: anchor.y)
            .rotated(by: CGFloat(angle.radians))
            .translatedBy(x: -anchor.x, y: -anchor.y)
        
        let rotated = Path(CGRect(origin: holeRect.origin, size: holeRect.size)).applying(transform)
        path.addPath(rotated)

        return path
    }
}

/// 🔧 스크롤 위치 추적용 PreferenceKey
struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

/// 💡 메인 View
struct BannerAndScrollEffectView: View {
    @State private var scrollOffset: CGFloat = 0
    let bannerHeight: CGFloat = 500

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                GeometryReader { geo in
                    let offset = geo.frame(in: .named("scroll")).minY
                    Color.clear
                        .preference(key: ScrollOffsetKey.self, value: offset)
                }
                .frame(height: 0)

                ZStack {
                    // 🔹 선명한 배너 이미지 (기본 바닥)
                    Image("mockBanner")
                        .resizable()
                        .scaledToFill()
                        .frame(height: bannerHeight)

                    // 🔹 블러 처리된 이미지 중, 구멍 영역만 보이게 마스크 처리
                    Image("mockBanner")
                        .resizable()
                        .scaledToFill()
                        .frame(height: bannerHeight)
                        .blur(radius: 10)
                        .mask(
                            RotatingRectHole(
                                angle: angleForScroll(scrollOffset),
                                offsetX: 61,
                                offsetY: offsetYForScroll(scrollOffset) - 30 ,
                                holeWidth: 131,
                                holeHeight: 413
                            )
                            .fill(style: FillStyle(eoFill: true))  // 🔁 eoFill 유지
                        )
                }

                // 리스트 콘텐츠
                ForEach(0..<20, id: \.self) { i in
                    Text("리스트 항목 \(i)")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                }
            }
        }
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(ScrollOffsetKey.self) { value in
            scrollOffset = -value
        }
    }

    // MARK: - 스크롤에 따른 값 계산

    /// 0 → 90도까지 회전
    func angleForScroll(_ offset: CGFloat) -> Angle {
        let progress = min(max(offset / 300, 0), 1)
        return .degrees(90 * progress)
    }

    /// 위로 0 → -50까지 이동
    func offsetYForScroll(_ offset: CGFloat) -> CGFloat {
        let progress = min(max(offset / 300, 0), 1)
        return -50 * progress
    }
}

#Preview {
    BannerAndScrollEffectView()
}
