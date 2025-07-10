import SwiftUI

struct BrandCardView: View {
    var brand: BrandCard

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // 배경
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 99, height: 124)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color("CardGradiantblack").opacity(0),
                            Color("CardGradiant").opacity(0.7)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .background(
                    Image(brand.brandBanner)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 99, height: 124)
                )
                .cornerRadius(12)

            // ✅ 슬로건 텍스트 (우측 상단 정렬)
            Text(brand.slogan)
                .font(.system(size: 8))
                .foregroundColor(.white)
                .multilineTextAlignment(.trailing)
                .lineLimit(2)
                .truncationMode(.tail)
                .frame(width: 70, alignment: .trailing)
                .padding(6)

            // ✅ 하단 중앙에 로고 + 브랜드명
            VStack {
                Spacer()
                HStack(spacing: 6) {
                    Image(brand.brandLogo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14, height: 14)
                        .clipShape(Circle())
                        .padding(1)

                    Text(brand.brandName)
                        .font(.custom("Pretendard-Medium", size: 10))
                        .foregroundColor(Color("BrandNameColor"))
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .allowsTightening(true)
                        .frame(width: 49, alignment: .leading)
                }
                .padding(.horizontal, 4)
                .padding(.vertical, 3)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("BrandGroupColor"))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color("BrandNameColor"), lineWidth: 1)
                )
                .frame(maxWidth: .infinity) // ✅ 수평 중앙 정렬
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
            }
        }
        .frame(width: 99, height: 124)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
    }
}
