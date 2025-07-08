import SwiftUI // SwiftUI 프레임워크를 가져옵니다. UI를 선언적으로 구축하는 데 필요합니다.

/// `BrandInfoOverlayView`는 브랜드 상세 정보(로고, 이름, 설명, 좋아요 버튼, 쇼핑몰 링크)를
/// 배너 위에 오버레이 형태로 표시하는 뷰입니다.
/// 스크롤 위치에 따라 반응하거나, 설명 텍스트를 펼치고 접는 기능을 제공합니다.
struct BrandInfoOverlayView: View {
    let scrollOffset: CGFloat      // 외부에서 전달받는 스크롤 위치 값입니다. UI 요소의 위치나 불투명도 조절에 사용될 수 있습니다.
    let bannerHeight: CGFloat      // 배너의 높이 값입니다. 주로 UI 요소의 상대적 위치 계산에 사용됩니다.
    let brand: Brand               // 표시할 브랜드 데이터를 담고 있는 `Brand` 모델 객체입니다.

    // `@State` 프로퍼티 래퍼를 사용하여 뷰 내부에서 관리되는 상태 변수를 선언합니다.
    @State private var showFullText = false // 브랜드 설명 텍스트의 '더보기' 또는 '닫기' 상태를 제어합니다.
    @State private var isLiked = false      // 좋아요(스크랩) 버튼의 선택 상태를 제어합니다.

    /// 브랜드 설명 텍스트를 반환하는 계산 속성입니다.
    /// 현재는 `brand` 모델의 `description` 속성에서 직접 가져옵니다.
    var descriptionText: String {
        brand.description
    }

    // MARK: - Body

    var body: some View {
        let textColor = Color.white // 텍스트 색상을 흰색으로 통일하여 가독성을 높입니다.

        // 모든 내용을 수직으로 정렬하고 배치하기 위한 `VStack`입니다.
        // `alignment: .leading`으로 왼쪽 정렬하고, `spacing: 8`로 각 요소 사이에 8pt 간격을 둡니다.
        VStack(alignment: .leading, spacing: 8) {
            // 🔹 브랜드 로고 이미지
            Image(brand.brandLogoUrl) // `Brand` 모델에서 로고 이미지 이름을 가져와 표시합니다.
                .resizable()          // 이미지 크기를 조절할 수 있도록 설정합니다.
                .frame(width: 48, height: 48) // 로고 이미지의 고정 크기를 48x48pt로 지정합니다.
                .clipShape(Circle())  // 이미지를 원형으로 자릅니다.
                // 원형 로고 주위에 흰색 테두리를 추가합니다.
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 4)    // 로고에 그림자 효과를 적용하여 입체감을 더합니다.
                .padding(.bottom, 7)  // 로고 아래쪽에 7pt의 여백을 추가합니다.

            // 🔹 브랜드 이름, 레벨 이미지, 좋아요 버튼을 가로로 배치하는 `HStack`
            HStack(alignment: .center, spacing: 8) {
                // 브랜드 이름 텍스트
                Text(brand.name)
                    // "Pretendard-Regular" 폰트와 35pt 크기를 적용합니다.
                    .font(.custom("Pretendard-Bold", size: 35))
                    .foregroundColor(textColor) // `textColor` (흰색)를 적용합니다.
                    // 텍스트가 줄바꿈되지 않고 한 줄에 표시되도록 설정합니다.
                    .fixedSize(horizontal: true, vertical: false)

                // 브랜드 레벨 이미지 (예: 등급 아이콘)
                // `brand.brandLevel` 값을 사용하여 "Level1", "Level2"와 같은 이미지 이름을 동적으로 생성합니다.
                Image("Level\(brand.brandLevel)")
                    .resizable()                // 이미지 크기 조절 가능하도록 설정합니다.
                    .frame(width: 50, height: 50) // 고정 크기를 50x50pt로 지정합니다.

                // `Spacer`를 사용하여 브랜드 이름과 좋아요 버튼 사이에 최소 90pt의 공간을 확보합니다.
                Spacer(minLength: 90)

                // 좋아요(스크랩) 버튼
                Button(action: {
                    // `withAnimation` 블록 안에서 상태를 변경하여 부드러운 애니메이션 효과를 적용합니다.
                    withAnimation {
                        isLiked.toggle() // `isLiked` 상태를 토글합니다 (true <-> false).
                    }
                    // TODO: 실제 좋아요 상태를 서버에 저장하거나 삭제하는 로직을 여기에 추가해야 합니다.
                }) {
                    // `isLiked` 상태에 따라 채워진 하트("heart.fill") 또는 빈 하트("heart") 아이콘을 표시합니다.
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .font(.system(size: 24)) // 시스템 아이콘 폰트 크기를 24pt로 설정합니다.
                        // `isLiked` 상태에 따라 아이콘 색상을 파란색 또는 흰색으로 변경합니다.
                        .foregroundColor(isLiked ? .blue : .white)
                }
                // 남은 공간을 모두 채워 버튼을 오른쪽 끝으로 밀어냅니다.
                Spacer()
            }
            .padding(.bottom, 5) // `HStack` 아래쪽에 10pt의 여백을 추가합니다.
            
            Text(brand.brandGenre)
                .font(.custom("Prentendard-Medium", size: 10))
                .foregroundColor(Color.white)
                .opacity(0.7)
                .frame(height: 16) // 명시적 높이 지정
                .frame(minWidth: 48) // 너비 제한(옵션)
                .background(
                    RoundedRectangle(cornerRadius: 12) // 배경 둥근 사각형
                        .fill(Color.BrandGenre) // 배경색 지정
                )
                .overlay( // 테두리 덧붙이기
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.BrandFont, lineWidth: 1) // 흰색 외곽선
                )
                
            // 🔹 브랜드 설명 텍스트와 쇼핑몰 링크 버튼을 가로로 배치하는 `HStack`
            HStack(alignment: .top, spacing: 8) {
                // 설명 텍스트 영역 (`더보기/닫기` 토글 기능 포함)
                VStack(alignment: .leading, spacing: 0) {
                    // `showFullText` 상태에 따라 전체 텍스트 또는 잘린 텍스트를 표시합니다.
                    if showFullText {
                        // 전체 설명 텍스트와 "닫기" 텍스트를 결합하여 표시합니다.
                        (
                            Text(descriptionText)      // 전체 브랜드 설명 텍스트
                            + Text("   닫기")          // "닫기" 텍스트를 추가합니다.
                                .bold()                // "닫기" 텍스트를 굵게 표시합니다.
                                // "Pretendard-Regular" 폰트와 12pt 크기를 적용합니다.
                                .font(.custom("Pretendard-Light", size: 12))
                        )
                        .font(.system(size: 12))     // 전체 텍스트 블록의 폰트 크기를 12pt로 설정합니다.
                        .foregroundColor(textColor)  // 흰색 텍스트 색상을 적용합니다.
                        .onTapGesture {
                            // "닫기" 텍스트를 탭하면 애니메이션과 함께 `showFullText`를 false로 변경합니다.
                            withAnimation {
                                showFullText = false
                            }
                        }
                        // 뷰가 사라질 때 아래쪽으로 이동하는 애니메이션 효과를 적용합니다.
                        .transition(.move(edge: .bottom))
                    } else {
                        // 잘린 설명 텍스트와 "더보기" 텍스트를 결합하여 표시합니다.
                        (
                            Text(truncatedText + "... ") // `truncatedText` (60자 기준 잘린 텍스트)와 "..."를 표시합니다.
                            + Text("더보기")           // "더보기" 텍스트를 추가합니다.
                                .bold()                // "더보기" 텍스트를 굵게 표시합니다.
                                // "Pretendard-Regular" 폰트와 12pt 크기를 적용합니다.
                                .font(.custom("Pretendard-Regular", size: 12))
                        )
                        .font(.system(size: 12))     // 전체 텍스트 블록의 폰트 크기를 12pt로 설정합니다.
                        .foregroundColor(textColor)  // 흰색 텍스트 색상을 적용합니다.
                        .onTapGesture {
                            // "더보기" 텍스트를 탭하면 애니메이션과 함께 `showFullText`를 true로 변경합니다.
                            withAnimation {
                                showFullText = true
                            }
                        }
                    }
                }
                // 설명 텍스트 영역의 최대 너비를 220pt로 제한하고, 텍스트를 왼쪽으로 정렬합니다.
                .frame(maxWidth: 220, alignment: .leading)
                .padding(.top,12)

                // 🔹 쇼핑몰 열기 버튼 (카트 아이콘)
                Button(action: {
                    // `brand.brandHomePageUrl`에서 URL을 생성할 수 있는지 확인합니다.
                    if let url = URL(string: brand.brandHomePageUrl) {
                        // 유효한 URL인 경우 `UIApplication.shared.open()`을 사용하여
                        // Safari와 같은 외부 앱으로 URL을 엽니다.
                        UIApplication.shared.open(url)
                    }
                }) {
                    // "shop"이라는 이름의 이미지를 아이콘으로 사용합니다.
                    Image("shop")
                        .font(.system(size: 18)) // 아이콘의 폰트 크기를 18pt로 설정합니다.
                        .foregroundColor(.white) // 아이콘 색상을 흰색으로 설정합니다.
                }
                .padding(.top, 2)         // 버튼 위쪽에 2pt 여백을 추가합니다.
                // 설명 텍스트와 쇼핑몰 버튼 사이의 간격을 넓히기 위해 왼쪽 패딩을 추가합니다.
                // 이 값은 디자인에 따라 조정될 수 있습니다.
                .padding(.leading, 100)
            }
        }
        // `VStack` 전체에 상하좌우 12pt, 16pt의 패딩을 적용합니다.
        .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
        // `VStack`이 가능한 최대 너비로 확장되고 내용을 왼쪽으로 정렬하도록 설정합니다.
        .frame(maxWidth: .infinity, alignment: .leading)
        // 배경색을 투명한 검정색으로 설정합니다. (opacity 0.0)
        .background(Color.black.opacity(0.0))
        .cornerRadius(12) // 뷰의 모서리를 12pt 반경으로 둥글게 만듭니다.
        .shadow(radius: 8) // 뷰에 그림자 효과를 적용하여 입체감을 부여합니다.
    }

    /// `descriptionText`를 60자 기준으로 자른 문자열을 반환하는 계산 속성입니다.
    /// `showFullText`가 `false`일 때 '더보기'와 함께 사용됩니다.
    var truncatedText: String {
        if descriptionText.count > 60 {
            // 텍스트가 60자보다 길면 60번째 인덱스까지 자릅니다.
            let index = descriptionText.index(descriptionText.startIndex, offsetBy: 60)
            return String(descriptionText[..<index])
        } else {
            // 텍스트가 60자 이하면 전체 텍스트를 반환합니다.
            return descriptionText
        }
    }
}

#Preview {
    let mockBrand = Brand(
        id: UUID(),
        name: "샘플 브랜드",
        brandGenre: "스트릿",
        description: "이 브랜드는 세련된 디자인과 감각적인 제품으로 유명합니다. 개성 있고 유니크한 브랜드 스토리를 가지고 있으며, 많은 셀럽들이 착용한 이력이 있습니다.",
        brandBannerUrl: "brandBanner",
        brandLogoUrl: "brandLogo",
//        isScraped: false,
        brandHomePageUrl: "https://www.example.com",
        brandLevel: 1
    )
    
     ZStack {
        Color.black // 배경 확인용
        BrandInfoOverlayView(
            scrollOffset: 0,
            bannerHeight: 300,
            brand: mockBrand
        )
    }
    .frame(height: 250)
}
