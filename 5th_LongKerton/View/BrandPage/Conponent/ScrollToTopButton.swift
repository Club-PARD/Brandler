import SwiftUI // SwiftUI 프레임워크를 가져옵니다. UI를 선언적으로 구축하는 데 필요합니다.

/// `ScrollToTopButton`은 스크롤 뷰의 상단으로 부드럽게 이동할 수 있는 버튼을 제공하는 뷰입니다.
/// 특정 스크롤 위치에서만 나타나도록 제어될 수 있습니다.
struct ScrollToTopButton: View {
    // `ScrollViewProxy`는 `ScrollView` 내부의 특정 뷰로 스크롤할 수 있는 기능을 제공합니다.
    // 이 버튼이 작동하려면 상위 `ScrollView`에서 이 프록시를 주입해야 합니다.
    let proxy: ScrollViewProxy?
    
    // 버튼의 가시성을 제어하는 Bool 값입니다.
    // 이 값이 `true`일 때만 버튼이 화면에 나타납니다.
    let visible: Bool

    // MARK: - Body

    var body: some View {
        // `Group` 뷰는 조건부로 뷰를 포함하거나 포함하지 않을 때 유용합니다.
        // 여기서는 `proxy`가 `nil`이 아니고 `visible`이 `true`일 때만 버튼을 렌더링합니다.
        Group {
            if let proxy = proxy, visible {
                // 버튼을 정의합니다.
                Button(action: {
                    // `withAnimation` 블록 안에서 스크롤 작업을 수행하여 부드러운 애니메이션을 적용합니다.
                    withAnimation {
                        // `proxy.scrollTo()` 메서드를 사용하여 "top"이라는 ID를 가진 뷰의 `.top` 앵커로 스크롤합니다.
                        // "top" ID는 스크롤 뷰의 맨 위에 위치한 어떤 뷰에 할당되어야 합니다.
                        proxy.scrollTo("top", anchor: .top)
                    }
                }) {
                    // 버튼의 시각적 내용을 정의합니다 (화살표 원형 아이콘).
                    Image(systemName: "arrow.up.circle.fill") // 시스템 아이콘 "arrow.up.circle.fill" 사용
                        .font(.system(size: 40)) // 아이콘 크기를 40pt로 설정
                        .foregroundColor(Color.white).opacity(0.5) // 흰색에 50% 투명도 적용
                        .padding(12) // 아이콘 주위에 12pt 패딩 추가
                        .clipShape(Circle()) // 아이콘을 원형으로 자름
                        .shadow(radius: 5) // 그림자 효과를 추가하여 입체감 부여
                }
                // 버튼 자체의 패딩을 설정합니다.
                .padding(.trailing, 20) // 오른쪽에서 20pt 안으로
                .padding(.bottom, 30)   // 아래쪽에서 30pt 위로
                // 버튼의 위치를 화면의 오른쪽 하단에 고정합니다.
                // `maxWidth: .infinity`, `maxHeight: .infinity`와 `alignment: .bottomTrailing`을 함께 사용합니다.
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                // `zIndex`를 높게 설정하여 버튼이 다른 콘텐츠 위에 항상 표시되도록 합니다.
                .zIndex(1000)
                // 뷰가 나타나거나 사라질 때 크기 조정(scale) 애니메이션을 적용합니다.
                .transition(.scale)
            }
        }
    }
}
