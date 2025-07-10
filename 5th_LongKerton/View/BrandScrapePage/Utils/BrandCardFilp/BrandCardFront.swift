import SwiftUI

struct BrandCardFront: View {
    let brand: BrandCard

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // 배경 이미지
            Image(brand.brandBanner)
                .resizable()
                .scaledToFill()
                .frame(width: 99, height: 124)
                .clipped()
                .opacity(0.7)

            // 그라디언트 오버레이
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

            // 슬로건 (우측 상단)
            Text(brand.slogan)
                .font(.system(size: 8))
                .foregroundColor(.white)
                .multilineTextAlignment(.trailing)
                .lineLimit(2)
                .truncationMode(.tail)
                .frame(width: 70, alignment: .trailing)
                .padding(6)

            // 하단 로고 + 이름 (정중앙 정렬)
            VStack {
                Spacer()

                HStack(spacing: 6) {
                    Image(brand.brandLogo)
                        .resizable()
                        .frame(width: 14, height: 14)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 1))

                    Text(brand.brandName)
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
                .frame(maxWidth: .infinity) // ✅ 정중앙 정렬을 위해 가로 확장
                .multilineTextAlignment(.center)
                .padding(.bottom, 7)
            }
        }
        .frame(width: 99, height: 124)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
    }
}
