import SwiftUI

struct BrandInfoOverlayView: View {
    let scrollOffset: CGFloat      // 스크롤 위치를 외부에서 전달받아 UI 반응에 사용
    let bannerHeight: CGFloat      // 배너 높이, 필요 시 위치 계산용
    let brand: Brand
    @State private var showFullText = false  // 설명 텍스트의 '더보기/닫기' 상태를 로컬 상태로 관리
    @State private var isLiked = false        // 좋아요 상태를 로컬 상태로 관리 (스크랩 여부)
    
    // 브랜드 설명 텍스트 (나중에 모델에서 받아오는 데이터로 교체 예정)
    var descriptionText: String {
        brand.description
    }
    
    // 브랜드 쇼핑몰 URL (나중에 모델에서 받아오기)
//    let storeURL = "https://www.frizm.co.kr/"
    
    var body: some View {
        let textColor = Color.white   // 텍스트 색상 지정
        
        VStack(alignment: .leading, spacing: 8) {
            // 🔹 브랜드 로고 이미지
            Image(brand.brandLogoUrl)               // 브랜드 로고 이미지 (모델에서 받아올 예정)
                .resizable()                 // 크기 조절 가능하도록
                .frame(width: 48, height: 48) // 고정 크기 지정
                .clipShape(Circle())         // 원형 모양으로 자름
                .overlay(Circle().stroke(Color.white, lineWidth: 2)) // 흰색 테두리 원 추가
                .shadow(radius: 4)           // 그림자 효과
                .padding(.bottom, 7)         // 아래쪽 여백 7pt
            
            // 🔹 브랜드 이름, 레벨 이미지, 좋아요 버튼을 가로로 배치하는 HStack
            HStack(alignment: .center, spacing: 8) {
                // 브랜드 이름 텍스트 (모델에서 받아오기 예정)
                Text(brand.name)
                    .font(.system(size: 35)) // 크고 두꺼운 폰트
                    .foregroundColor(textColor)
                
                // 브랜드 레벨 이미지 (예: 등급 아이콘)
                Image("Level\(brand.brandLevel)")// brand 레벨을 모델에서 받아와서 쓰기
                    .resizable()
                    .frame(width: 50, height: 50) // 고정 크기
                
                Spacer(minLength: 90)  // 브랜드 이름과 좋아요 버튼 사이 공간 확보
                
                // 좋아요(스크랩) 버튼
                Button(action: {
                    withAnimation {
                        isLiked.toggle()    // 좋아요 상태 토글 및 애니메이션 효과
                    }
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")  // 채워진 하트/빈 하트 아이콘 토글
                        .font(.system(size: 24))
                        .foregroundColor(isLiked ? .blue : .white)       // 좋아요 시 파란색, 아니면 흰색
                }
                // TODO: 실제 좋아요 상태 저장/삭제 로직 추가 필요
                
                Spacer()  // 오른쪽 끝으로 밀기
            }
            .padding(.bottom, 10)  // HStack 아래쪽 여백 10pt
            
            // 🔹 브랜드 설명 텍스트 + 쇼핑몰 링크 버튼을 가로 배치하는 HStack
            HStack(alignment: .top, spacing: 8) {
                // 설명 텍스트 영역 (더보기/닫기 토글 기능 포함)
                VStack(alignment: .leading, spacing: 0) {
                    if showFullText {
                        (
                            Text(descriptionText)      // 전체 설명 텍스트
                            + Text("   닫기")          // 닫기 텍스트 (굵게 표시)
                                .bold()
                        )
                        .font(.system(size: 12))       // 작은 크기 폰트
                        .foregroundColor(textColor)    // 흰색 텍스트
                        .onTapGesture {
                            // 닫기 클릭 시 애니메이션과 함께 전체 텍스트 닫기
                            withAnimation {
                                showFullText = false
                            }
                        }
                        .transition(.move(edge: .bottom)) // 닫을 때 아래쪽으로 사라지는 애니메이션 효과
                    } else {
                        (
                            Text(truncatedText + "... ") // 자른 설명 텍스트 + 말줄임표
                            + Text("더보기")              // 더보기 텍스트 (굵게 표시)
                                .bold()
                        )
                        .font(.system(size: 12))
                        .foregroundColor(textColor)
                        .onTapGesture {
                            // 더보기 클릭 시 애니메이션과 함께 전체 텍스트 펼치기
                            withAnimation {
                                showFullText = true
                            }
                        }
                    }
                }
                // 설명 텍스트 영역 최대 너비 220pt 제한 및 왼쪽 정렬
                .frame(maxWidth: 220, alignment: .leading)
                
                // 🔹 쇼핑몰 열기 버튼 (카트 아이콘)
                Button(action: {
                    if let url = URL(string: brand.brandHomePageUrl) {
                        UIApplication.shared.open(url)  // URL 열기 (Safari 등)
                    }
                }) {
                    Image("shop")
                        .font(.system(size: 18))     // 적당한 크기 아이콘
                        .foregroundColor(.white)     // 흰색 아이콘
                }
                .padding(.top, 2)               // 버튼 위쪽 여백
                .padding(.leading, 92)          // 설명 텍스트와 떨어뜨리기 위해 왼쪽 패딩 추가 (필요시 조정 가능)
            }
        }
        .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))  // 전체 패딩 적용
        .frame(maxWidth: .infinity, alignment: .leading)                      // 최대 너비 확장 + 왼쪽 정렬
        .background(Color.black.opacity(0.0))                                // 배경 투명 (필요시 변경 가능)
        .cornerRadius(12)                                                    // 모서리 둥글게
        .shadow(radius: 8)                                                   // 그림자 효과로 입체감 부여
    }
    
    // 설명 텍스트를 60자 기준으로 자른 자막 (더보기 전 상태에 사용)
    var truncatedText: String {
        if descriptionText.count > 60 {
            let index = descriptionText.index(descriptionText.startIndex, offsetBy: 60)
            return String(descriptionText[..<index])
        } else {
            return descriptionText
        }
    }
}

// MARK: - 미리보기 설정
//#Preview {
//    struct PreviewWrapper: View {
//        @State private var scrollOffset: CGFloat = 0    // 스크롤 오프셋 시뮬레이션 상태
//        let bannerHeight: CGFloat = 500                  // 배너 높이 고정값
//
//        var body: some View {
//            ZStack {
//                // 배경으로 빨간색 박스 (배너 위치 가시화용)
//                Rectangle()
//                    .fill(Color.red)
//                    .frame(height: bannerHeight)
//
//                // 브랜드 오버레이 뷰
//                BrandInfoOverlayView(
//                    scrollOffset: scrollOffset,
//                    bannerHeight: bannerHeight
//                )
//
//                VStack {
//                    Spacer()
//                    // 슬라이더로 스크롤 오프셋 값 조정 가능 (디버깅/테스트용)
//                    Slider(value: $scrollOffset, in: 0...300)
//                        .padding()
//                }
//            }
//            .frame(height: bannerHeight)  // 전체 프리뷰 높이 지정
//            .background(Color.black)      // 배경색 검정으로 설정
//        }
//    }
//
//    return PreviewWrapper()
//}
