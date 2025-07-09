import SwiftUI // SwiftUI 프레임워크를 가져옵니다. UI를 선언적으로 구축하는 데 필요합니다.

/// `TopTabBarView`는 앱 화면 상단에 위치하는 커스텀 탭바(내비게이션 바) 뷰입니다.
/// 스크롤 위치에 따라 배경의 투명도와 브랜드 이름의 가시성이 동적으로 변하는 인터랙티브한 디자인을 제공합니다.
struct TopTabBarView: View {
    // MARK: - Properties

    // `tabBarScrollOffset`은 스크롤 뷰의 Y축 오프셋을 나타내는 CGFloat 값입니다.
    // 이 값은 부모 뷰에서 전달받으며, 탭바의 시각적 변화를 트리거하는 데 사용됩니다.
    let tabBarScrollOffset: CGFloat
    
    // 탭바 중앙에 표시될 브랜드 이름 문자열입니다.
    let brandName: String
    
    // `@Environment(\.dismiss)`는 현재 뷰를 닫는 데 사용되는 환경 값을 가져옵니다.
    // 주로 Sheet 또는 NavigationStack의 push된 뷰를 닫을 때 사용됩니다.
    @Environment(\.dismiss) var dismiss

    // MARK: - Body

    var body: some View {
        // `ZStack`을 사용하여 여러 뷰를 깊이(Z-axis) 방향으로 겹쳐서 배치합니다.
        // 여기서는 배경색, 뒤로 가기 버튼, 브랜드 이름이 겹쳐집니다.
        ZStack {
            // 검은색 배경을 정의합니다.
            Color.BgColor
                // 배경의 투명도를 `backgroundOpacity` 계산 속성에 따라 동적으로 조절합니다.
                // 스크롤 위치에 따라 탭바 배경이 점진적으로 나타나거나 사라집니다.
                .opacity(backgroundOpacity)
                // 화면의 안전 영역(예: 노치)까지 배경색이 확장되도록 합니다.
                .ignoresSafeArea(edges: .top)

            // `HStack`을 사용하여 뒤로 가기 버튼, 브랜드 이름, 빈 공간을 가로로 정렬합니다.
            HStack {
                // 뒤로 가기 버튼을 정의합니다.
                Button(action: {
                    dismiss()
                }) {
                    // 뒤로 가기 버튼의 아이콘으로 시스템 이미지 "chevron.left"를 사용합니다.
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white) // 아이콘 색상을 흰색으로 설정합니다.
                        .padding(.leading, 16)   // 왼쪽 가장자리에서 16pt 패딩을 추가합니다.
                }

                // 버튼과 브랜드 이름 사이에 유연한 공간을 추가하여 브랜드 이름을 중앙에 가깝게 밀어냅니다.
                Spacer()

                // 브랜드 이름을 조건부로 표시합니다.
                // `tabBarScrollOffset`이 450pt 이상일 때만 브랜드 이름이 나타납니다.
                if tabBarScrollOffset >= 450 {
                    Text(brandName) // 브랜드 이름을 표시합니다.
                        .font(.system(size: 18, weight: .semibold)) // 폰트 크기 18pt, 세미볼드 적용
                        .foregroundColor(.white) // 텍스트 색상을 흰색으로 설정합니다.
                        // 브랜드 이름의 투명도도 배경과 동일하게 `backgroundOpacity`에 따라 조절됩니다.
                        .opacity(backgroundOpacity)
                        // 뷰가 나타나거나 사라질 때 페이드(opacity) 애니메이션을 적용합니다.
                        .transition(.opacity)
                }

                // 브랜드 이름과 오른쪽 끝 사이에 유연한 공간을 추가합니다.
                Spacer()
                
                // 오른쪽 뒤로 가기 버튼의 왼쪽 패딩과 정렬을 맞추기 위한 빈 `Spacer`입니다.
                // (일반적으로 왼쪽 버튼의 너비와 동일하게 설정하여 중앙 정렬을 돕습니다.)
                Spacer().frame(width: 44) // `chevron.left` 버튼의 너비(패딩 포함)와 유사하게 설정됩니다.
            }
            .frame(height: 60) // `HStack`의 고정 높이를 60pt로 설정합니다.
            // 상단 안전 영역(`safeAreaInsetTop`)만큼 `HStack`을 아래로 내립니다.
            .padding(.top, safeAreaInsetTop)
        }
        // `ZStack` 전체의 높이를 탭바 높이(60pt)와 상단 안전 영역 높이의 합으로 설정합니다.
        .frame(height: 60 + safeAreaInsetTop)
        // `backgroundOpacity` 값 변화에 대해 0.3초의 `easeInOut` 애니메이션을 적용합니다.
        // 이는 스크롤 시 배경과 브랜드 이름이 부드럽게 나타나고 사라지게 합니다.
        .animation(.easeInOut(duration: 0.3), value: backgroundOpacity)
    }

    // MARK: - Helper Properties

    /// `tabBarScrollOffset` 값을 기반으로 탭바 배경의 투명도를 계산합니다.
    /// 스크롤 오프셋이 500pt에서 560pt 사이일 때 투명도가 0.0에서 1.0으로 선형적으로 증가합니다.
    private var backgroundOpacity: Double {
        let start: CGFloat = 500 // 투명도가 증가하기 시작하는 스크롤 오프셋
        let end: CGFloat = 560   // 투명도가 1.0에 도달하는 스크롤 오프셋
        
        // `tabBarScrollOffset`이 `start`와 `end` 범위 내에 있도록 값을 클램프(clamp)합니다.
        let clamped = min(max(tabBarScrollOffset - start, 0), end - start)
        
        // 클램프된 값을 전체 범위(`end - start`)로 나누어 0.0에서 1.0 사이의 투명도 값을 반환합니다.
        return Double(clamped / (end - start))
    }

    /// 현재 기기의 상단 안전 영역(Safe Area Inset) 높이를 계산합니다.
    /// 이는 노치, 다이내믹 아일랜드 등 시스템 UI 요소에 의해 가려지지 않는 영역을 확보하는 데 사용됩니다.
    private var safeAreaInsetTop: CGFloat {
        // 현재 연결된 모든 씬(Scenes)을 가져옵니다.
        UIApplication.shared.connectedScenes
            // `UIWindowScene` 타입이고 `keyWindow`가 있는 씬만 필터링하고, 해당 윈도우의 `safeAreaInsets.top` 값을 추출합니다.
            .compactMap { ($0 as? UIWindowScene)?.keyWindow?.safeAreaInsets.top }
            // 첫 번째로 찾은 유효한 `safeAreaInsets.top` 값을 반환합니다.
            // 만약 아무것도 찾지 못하면 기본값으로 0을 사용합니다.
            .first ?? 0
    }
}
