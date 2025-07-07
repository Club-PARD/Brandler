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
                    Color.black.opacity(0.0),
                    Color.pageBlue.opacity(0.7)
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
                .background(Color.black.opacity(0.3))
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white, lineWidth: 1)
                )
                .cornerRadius(30)
                .padding(.bottom, 7)
            }
        }
        .frame(width: 99, height: 124)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
    }
}

#Preview {
    BrandCardFront(brand: Brand(
        id: UUID(),
        name: "테스트브랜드",
        brandGenre: "스트릿",
        description: "테스트 설명입니다.",
        brandBannerUrl: "mockLogo2",     // Assets에 있는 이미지 이름
        brandLogoUrl: "mockLogo1",        // Assets에 있는 로고 이름
        brandHomePageUrl: "https://example.com",
        brandLevel: 1
    ))
    .previewLayout(.sizeThatFits)
    .padding()
    .background(Color.gray)
}
