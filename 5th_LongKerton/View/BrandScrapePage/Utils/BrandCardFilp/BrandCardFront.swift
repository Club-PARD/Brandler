import SwiftUI // SwiftUI 프레임워크를 가져옵니다

// MARK: - 브랜드 카드 앞면 뷰
struct BrandCardFront: View {
    let brand: Brand // 표시할 브랜드 정보

    var body: some View {
        ZStack {
            // 배경 배너 이미지 표시
            Image(brand.brandBannerUrl)
                .resizable() // 이미지 크기 조정 가능
                .scaledToFill() // 프레임을 꽉 채우도록 비율 맞춤
                .frame(width: 99, height: 124) // 고정 크기
                .clipped() // 프레임 바깥 부분 잘라냄
                .opacity(0.7) // 이미지 반투명하게 처리

            // 위에서 아래로 어두워지는 그라디언트 오버레이
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.0), // 상단은 투명
                    Color.pageBlue.opacity(0.7) // 하단은 파란빛 반투명
                ]),
                startPoint: .top, // 위에서 시작
                endPoint: .bottom // 아래로 내려감
            )
            .frame(width: 99, height: 124) // 동일한 크기
            .clipShape(RoundedRectangle(cornerRadius: 12)) // 둥근 모서리 적용

            // 하단 영역에 로고 + 이름 배치
            VStack {
                Spacer() // 상단 공간 밀어내기

                HStack(spacing: 6) {
                    // 브랜드 로고 (원형 + 테두리)
                    Image(brand.brandLogoUrl)
                        .resizable() // 크기 조절
                        .frame(width: 14, height: 14) // 작게 표시
                        .clipShape(Circle()) // 원형 마스크
                        .overlay(Circle().stroke(Color.white, lineWidth: 1)) // 흰색 테두리

                    // 브랜드 이름 텍스트
                    Text(brand.name)
                        .font(.system(size: 10, weight: .medium)) // 작은 크기의 보통 굵기
                        .foregroundColor(Color.BrandCardFontColor) // 사용자 정의 색상
                        .lineLimit(1) // 한 줄로 제한
                        .truncationMode(.tail) // 너무 길면 말줄임표 처리
                        .frame(width: 49, alignment: .leading) // 고정 너비 및 왼쪽 정렬
                        .allowsTightening(true) // 글자 간격 자동 조절 허용
                }
                .padding(.horizontal, 4) // 좌우 여백
                .padding(.vertical, 3) // 상하 여백
                .background(Color.black.opacity(0.3)) // 반투명 배경
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white, lineWidth: 1) // 흰색 외곽선
                )
                .cornerRadius(30) // pill 형태로 둥글게
                .padding(.bottom, 7) // 하단 여백
            }
        }
        .frame(width: 99, height: 124) // 전체 카드 크기
        .clipShape(RoundedRectangle(cornerRadius: 12)) // 전체 모서리 둥글게
        .shadow(radius: 2) // 살짝 그림자 적용
    }
}

// MARK: - 프리뷰 (실행 시 미리보기용, 현재는 주석 처리됨)
//#Preview {
//    BrandCardFront(brand: Brand(
//        id: UUID(), // 임시 UUID
//        name: "테스트브랜드", // 브랜드명
//        brandGenre: "스트릿", // 장르
//        description: "테스트 설명입니다.", // 설명
//        brandBannerUrl: "mockLogo2", // 배너 이미지 (Assets에 있어야 함)
//        brandLogoUrl: "mockLogo1", // 로고 이미지 (Assets에 있어야 함)
//        brandHomePageUrl: "https://example.com", // 홈페이지 URL
//        brandLevel: 1 // 브랜드 레벨
//    ))
//    .previewLayout(.sizeThatFits) // 콘텐츠에 맞게 미리보기 크기 설정
//    .padding() // 프리뷰 패딩
//    .background(Color.gray) // 회색 배경
//}
