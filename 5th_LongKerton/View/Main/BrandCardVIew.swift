import SwiftUI

struct BrandCardVIew: View {
    var brand: BrandCard

    var body: some View {
        ZStack(alignment: .bottom) {
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

            HStack {
                Image(brand.brandLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14)
                    .clipShape(Circle())
                    .padding(1)

                VStack(alignment: .center) {
                    Text(brand.brandName)
                        .font(.custom("Pretendard-Medium", size: 10))
                        .foregroundColor(Color("BrandNameColor"))
                        .lineLimit(1) // ✅ 한 줄로 제한
                        .truncationMode(.tail) // ✅ 넘칠 경우 ... 처리
                        .allowsTightening(true) // ✅ 글자 간격 자동 조정 허용
                        .frame(width: 49, alignment: .leading) // ✅ 고정 너비 설정
                }
            }
            .frame(width: 81, height: 16, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color("BrandGroupColor"))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color("BrandNameColor"), lineWidth: 1)
            )
            .padding(.bottom, 8)
        }
    }
}
