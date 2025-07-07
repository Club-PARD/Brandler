import SwiftUI

struct BrandCardFront: View {
    let brand: Brand
    
    var body: some View {
        ZStack {
            // 배경 배너 이미지
            Image(brand.brandBannerUrl)
                .resizable()
                .scaledToFill()
                .frame(width: 99, height: 124)
                .clipped()
                .opacity(0.7) 
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.0), // #00000000
                    Color.pageBlue.opacity(0.7) // #496FFF + B2 = 약 70%
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(width: 99, height: 124)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            // 하단 정렬용 VStack
            VStack {
                Spacer() // 상단 공간을 밀어냄
                
                // 브랜드 로고 + 이름 (좌우 배치)
                HStack(spacing: 6) {
                    Image(brand.brandLogoUrl)
                        .resizable()
                        .frame(width: 14, height: 14)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 1))
                    
                    Text(brand.name)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(Color.BrandCardFontColor)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .frame(width: 49, alignment: .leading)
                        .allowsTightening(true)
                }
                .padding(.horizontal, 4)
                .padding(.vertical, 3)
                .background(Color.black.opacity(0.5))
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white, lineWidth: 1)
                )
                .cornerRadius(30)
                .padding(.bottom, 7) // 하단에서 7px 간격
            }
        }
        .frame(width: 99, height: 124)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
    }
}

//#Preview {
//    BrandCardFront(
//        brand: MockBrand(
//            id: UUID(),
//            name: "브랜드",
//            genre: "스트릿",
//            description: "설명",
//            bannerImageName: "mockBanner1",
//            logoImageName: "mockLogo1"
//        )
//    )
//    .frame(width: 120, height: 180)
//    .background(Color.gray)
//}
