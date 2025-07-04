import SwiftUI

struct CategoryTabBarView: View {
    // 선택된 카테고리를 바인딩으로 받아서 부모 뷰와 상태 공유
    @Binding var selected: Category
    
    var body: some View {
        // 가로로 나열하는 HStack (카테고리 버튼들이 옆으로 배치됨)
        HStack(spacing: 12) {
            // Category enum의 모든 케이스를 순회하며 각각 버튼 생성
            ForEach(Category.allCases) { category in
                Button(action: {
                    // 버튼 탭 시 해당 카테고리를 선택 상태로 변경
                    selected = category
                }) {
                    // 버튼 내부 텍스트: 카테고리 원본 문자열(rawValue)
                    Text(category.rawValue)
                        // 버튼의 고정 크기 지정 (너비 70, 높이 31)
                        .frame(width: 70, height: 31)
                        // 버튼 배경으로 둥근 사각형 추가
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                // 선택된 카테고리이면 진한 파란색 (#002FFF), 아니면 어두운 회색 (#3E3E3E)
                                .fill(selected == category ? Color(hex: "#002FFF") : Color(hex: "#3E3E3E"))
                        )
                        // 글자 색상도 선택 여부에 따라 흰색 혹은 회색으로 변경
                        .foregroundColor(
                            selected == category ? Color(hex: "#FFFFFF") : Color(hex: "#878787")
                        )
                }
                // 버튼 좌우에 8pt 패딩 추가해 버튼 간격 확보
                .padding(.horizontal, 8)
            }
        }
        // 카테고리 탭바 전체 높이 70pt로 고정
        .frame(height: 70)
        // 가로 공간 최대한 넓게 사용하도록 지정
        .frame(maxWidth: .infinity)
        // 탭바 배경 색상 지정 (다크톤 #1B191A)
        .background(Color(hex: "#1B191A"))
    }
}

// MARK: - 미리보기용 래퍼 뷰
#Preview {
    struct PreviewWrapper: View {
        // 선택 상태를 관리하는 State 변수 (기본값 전체)
        @State private var selected: Category = .all

        var body: some View {
            VStack {
                // 실제 CategoryTabBarView 호출 (선택 바인딩만 전달)
                CategoryTabBarView(
                    selected: $selected
                )
                // 배경을 검은색으로 설정 (미리보기 구분용)
                .background(Color.black)

                // 현재 선택된 카테고리 텍스트 표시 (디버깅 및 시각화 용도)
                Text("Selected Category: \(selected.rawValue)")
                    .foregroundColor(.white)
                    .padding(.top)
            }
            // 전체 배경을 검은색으로 채우고 안전 영역까지 확장
            .background(Color.black.ignoresSafeArea())
        }
    }

    // PreviewWrapper를 미리보기 대상으로 반환
    return PreviewWrapper()
}
