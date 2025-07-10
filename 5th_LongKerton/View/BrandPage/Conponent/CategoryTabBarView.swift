import SwiftUI // SwiftUI 프레임워크를 가져옵니다. UI를 선언적으로 구축하는 데 필요합니다.

/// `CategoryTabBarView`는 다양한 카테고리를 표시하고 사용자가 선택할 수 있도록 하는 탭바 뷰입니다.
/// 선택된 카테고리 상태를 부모 뷰와 공유하며, 선택 여부에 따라 버튼의 시각적 스타일이 변경됩니다.
struct CategoryTabBarView: View {
    // `@Binding` 프로퍼티 래퍼를 사용하여 `selected` 변수를 부모 뷰와 동기화합니다.
    // 이는 자식 뷰에서 변경된 값이 부모 뷰의 원본 상태 변수에도 반영되도록 합니다.
    @Binding var selected: Category
    
    // MARK: - Body

    var body: some View {
        // `HStack`을 사용하여 카테고리 버튼들을 가로로 나열합니다.
        // `spacing: 12`는 각 버튼 사이에 12pt의 간격을 둡니다.
        HStack(spacing: 12) {
            // `Category.allCases`를 순회하며 각 카테고리에 대한 버튼을 생성합니다.
            // `Category` enum은 `CaseIterable` 및 `Identifiable` 프로토콜을 준수해야 합니다.
            ForEach(Category.allCases) { category in
                // 각 카테고리에 대한 `Button`을 정의합니다.
                Button(action: {
                    // 버튼이 탭될 때, `@Binding`으로 연결된 `selected` 상태를
                    // 현재 `category`로 업데이트합니다.
                    selected = category
                }) {
                    // 버튼의 시각적 내용을 정의합니다.
                    // 카테고리 enum의 `rawValue` (문자열 값)를 텍스트로 표시합니다.
                    Text(category.rawValue)
                        // 텍스트 뷰의 고정 크기를 너비 70pt, 높이 31pt로 지정합니다.
                        .frame(width: 70, height: 31)
                        .font(.custom("Pretendard-Semibold",size:12))
                        // 텍스트 뷰의 배경으로 둥근 사각형을 추가합니다.
                        .background(
                            RoundedRectangle(cornerRadius: 10) // 10pt의 둥근 모서리를 가진 사각형
                                // `selected` 카테고리가 현재 `category`와 같으면 `Color.barBlue` (진한 파란색)로 채우고,
                                // 그렇지 않으면 `Color.Gradient5` (어두운 회색)로 채웁니다.
                                .fill(selected == category ? Color.barBlue : Color.Gradient5)
                        )
                        // 텍스트의 전경색(글자색)을 정의합니다.
                        // 선택된 카테고리이면 `Color.white` (흰색)로, 아니면 `Color.EditTxt` (회색)로 변경합니다.
                        .foregroundColor(
                            selected == category ? Color.white : Color.EditTxt
                        )
                }
                // 각 버튼의 좌우에 8pt의 패딩을 추가합니다.
                // 이는 `HStack`의 `spacing`과 함께 버튼 간의 시각적인 여백을 제공합니다.
                .padding(.horizontal, 8)
            }
        }
        // `HStack` 전체의 높이를 70pt로 고정합니다.
//        .frame(height: 32)
        // `HStack`이 부모 뷰의 사용 가능한 가로 공간을 최대한 넓게 사용하도록 합니다.
        .frame(maxWidth: .infinity)
        // 탭바 전체의 배경 색상을 `Color.BgColor` (다크톤 #1B191A로 추정)로 지정합니다.
        .background(Color.BgColor)
    }
}
