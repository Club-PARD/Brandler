import SwiftUI

struct BrandCardFront: View {
    let brand: MockBrand

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                // 상단 배너 이미지
                Image(brand.bannerImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 100)
                    .clipped()

                // 하단 장르 텍스트 + 파란 배경
                VStack {
                    Spacer()
                    Text(brand.genre)
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blue)
            }

            // 중앙 로고 이미지 (중간에 걸쳐 뜨도록)
            Image(brand.logoImageName)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                .background(Circle().fill(Color.white))
                .offset(y: 80) // 배너 끝보다 약간 아래에 위치
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
    }
}

#Preview {
    BrandCardFront(
        brand: MockBrand(
            id: UUID(),
            name: "브랜드 A",
            genre: "스트릿",
            description: "설명",
            bannerImageName: "mockBanner1",
            logoImageName: "mockLogo1"
        )
    )
    .frame(width: 120, height: 180)
    .background(Color.gray)
}
