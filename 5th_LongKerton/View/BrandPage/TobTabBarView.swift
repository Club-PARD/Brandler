import SwiftUI

struct TopTabBarView: View {
    // tabBarScrollOffset만 활용 (외부에서 이 값만 넘겨줘야 함)
    let tabBarScrollOffset: CGFloat
    let brandName: String
    var backAction: (() -> Void)?
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            // 검은색 배경, 투명도는 tabBarScrollOffset 기반으로 동적 계산
            Color.BgColor
                .opacity(backgroundOpacity)
                .ignoresSafeArea(edges: .top)

            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .bold))
                        .padding(.leading, 16)
                }

                Spacer()

                // 스크롤 오프셋이 일정 이상일 때만 브랜드명 표시
                if tabBarScrollOffset >= 450 {
                    Text(brandName)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .opacity(backgroundOpacity)
                        .transition(.opacity)
                }

                Spacer()
                
                Spacer().frame(width: 44)
            }
            .frame(height: 60)
            .padding(.top, safeAreaInsetTop)
        }
        .frame(height: 60 + safeAreaInsetTop)
        .animation(.easeInOut(duration: 0.3), value: backgroundOpacity)
    }

    // tabBarScrollOffset 기준 500~560 사이에서 투명도 0~1로 선형 증가
    private var backgroundOpacity: Double {
        let start: CGFloat = 500
        let end: CGFloat = 560
        let clamped = min(max(tabBarScrollOffset - start, 0), end - start)
        return Double(clamped / (end - start))
    }

    // 상단 안전영역 (노치 등) 높이 계산
    private var safeAreaInsetTop: CGFloat {
        UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow?.safeAreaInsets.top }
            .first ?? 0
    }
}

// MARK: - 미리보기
struct TopTabBarView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var tabBarScrollOffset: CGFloat = 0    // tabBarScrollOffset 역할을 하는 값

        var body: some View {
            VStack(spacing: 20) {
                Spacer()    // 상단 공간 확보

                TopTabBarView(
                    tabBarScrollOffset: tabBarScrollOffset,       // 수정: scrollOffset → tabBarScrollOffset
                    brandName: "브랜드이름",
                    backAction: { print("Back tapped") }
                )
                .frame(height: 60)          // 미리보기 높이 고정
                .padding(.horizontal)       // 좌우 패딩 추가

                // 현재 tabBarScrollOffset 텍스트 표시
                Text("TabBar Scroll Offset: \(Int(tabBarScrollOffset))")
                    .foregroundColor(.white)

                // 슬라이더로 스크롤 위치 시뮬레이션 (0 ~ 1000)
                Slider(value: $tabBarScrollOffset, in: 0...1000)
                    .accentColor(.blue)       // 슬라이더 색상
                    .padding(.horizontal)

                Spacer()    // 하단 공간 확보
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))  // 배경 검정색 전체 영역 확장
        }
    }

    static var previews: some View {
        PreviewWrapper()
            .preferredColorScheme(.dark)   // 다크 모드 미리보기
    }
}
