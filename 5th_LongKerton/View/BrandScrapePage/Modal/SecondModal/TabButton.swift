import SwiftUI // SwiftUI 프레임워크 임포트

// MARK: - 커스텀 탭 버튼 뷰 생성 함수
@ViewBuilder
func TabButton(title: String, selected: Bool, action: @escaping () -> Void) -> some View {
    // 버튼을 생성하며, 클릭 시 애니메이션과 함께 액션 실행
    Button(action: {
        withAnimation(.easeInOut(duration: 0.3)) { // 부드러운 easeInOut 애니메이션
            action() // 외부에서 전달된 액션 실행
        }
    }) {
        VStack(spacing: 0) { // 수직 정렬 (spacing 없이 촘촘하게 배치)
            
            Spacer().frame(height: 20) // 상단 고정 여백 (탭 내부 여백 확보용)
            
            Text(title) // 탭 이름 텍스트
                .font(.system(size: 12)) // 글자 크기 설정
                .foregroundColor(Color.TabPurple) // 탭 텍스트 색상 (커스텀 색상)

            Spacer() // 아래쪽은 유동적으로 여백을 차지함
        }
        // 전체 높이 설정 (선택된 경우 추가 여백 포함)
        .frame(height: 40 + (selected ? 16 : 0)) // 선택되었을 때 더 높게 표시됨
        .frame(maxWidth: .infinity) // 가능한 너비 최대로 확장
        .padding(.horizontal, 10) // 좌우 여백 추가
        
        // 배경 설정
        .background(
            Group {
                if selected {
                    // 선택된 탭의 배경: 상단 둥근 사각형 + 반투명 배경
                    TopRoundedRectangle(radius: 12)
                        .fill(Color.ContentBackground.opacity(0.6))
                } else {
                    // 비선택 탭의 배경: 기본 회색
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.TabGray)
                }
            }
        )
        
        // 테두리 라인 (Stroke) 설정
        .overlay(
            Group {
                if selected {
                    // 선택된 탭의 테두리: 상단만 둥근 테두리 사용
                    StrokeExcludingBottom(radius: 16)
                        .stroke(Color.LogBlue, lineWidth: 1)
                } else {
                    // 일반 탭은 전체 라운드 테두리 적용
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.LogBlue, lineWidth: 1)
                }
            }
        )
    }
}
