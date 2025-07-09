import SwiftUI // SwiftUI 프레임워크 임포트

// MARK: - 브랜드 카드 뒷면 뷰 정의
struct BrandCardBack: View {
    let brand: BrandCard// 브랜드 정보
    let onDelete: () -> Void // 삭제 액션 클로저
    var onShop: () -> Void = {}  // 기본값으로 빈 클로저 제공 (선택적으로 사용 가능)

    @State private var showDeleteAlert = false // 삭제 확인 알림창 표시 상태

    var body: some View {
        ZStack(alignment: .topTrailing) { // 전체 카드 레이아웃: 상단 오른쪽 정렬 기준 ZStack
            Image(brand.brandBanner) // 브랜드 배너 이미지 표시
                .resizable() // 크기 조정 가능
                .scaledToFill() // 프레임을 채우도록 비율 유지
                .frame(width: 99, height: 124) // 고정 크기
                .opacity(0.5) // 반투명 처리
                .clipped() // 프레임 밖은 잘라냄

            VStack {
                Spacer() // 상단 공간 확보

                // 브랜드 설명 텍스트
                Text(brand.slogan)
                    .font(.system(size: 10)) // 작은 폰트
                    .foregroundColor(.white) // 흰색 텍스트
                    .padding() // 내부 여백 추가

                Spacer() // 하단 공간 확보
            }

            // 상단 오른쪽 버튼 영역
            HStack(spacing: 8) {
                NavigationLink(destination: BrandPage(brandId: brand.brandId)) {
                    Image("shop")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(6)
                        .background(Color.black.opacity(0.0))
                        .clipShape(Circle())
                }

                Spacer() // 두 버튼 사이 간격 확보

                // 삭제 버튼
                Button(action: {
                    showDeleteAlert = true // 알림창 표시
                }) {
                    Image(systemName: "xmark") // x 아이콘 (SF Symbols)
                        .foregroundColor(.white) // 아이콘 색상
                        .frame(width: 24, height: 24) // 버튼 크기
                        .background(Color.black.opacity(0.6)) // 반투명 배경
                        .clipShape(Circle()) // 원형 모양
                }
                // 삭제 확인 알림창 설정
                .alert("정말 삭제하시겠습니까?", isPresented: $showDeleteAlert) {
                    Button("삭제", role: .destructive) {
                        onDelete() // 삭제 클로저 실행
                    }
                    Button("취소", role: .cancel) {} // 취소 시 아무 동작 없음
                }
            }
            .padding(8) // 버튼 영역 전체 패딩
        }
        .clipShape(RoundedRectangle(cornerRadius: 12)) // 전체 카드 둥근 모서리 처리
        .shadow(radius: 2) // 약간의 그림자 추가
    }
}
