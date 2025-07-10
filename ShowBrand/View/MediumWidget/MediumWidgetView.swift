import SwiftUI

struct MediumWidgetView: View {
    let brand: BrandRecommendation

    var body: some View {
        // 디버깅용 출력
        print("bannerImageName: \(brand.bannerImageName), brandLogoImageName: \(brand.brandLogoImageName)")
        print("Image frame width: 340, height: 160")
        
        return ZStack(alignment: .topLeading) {
            Image(brand.bannerImageName)
                .resizable()
                .frame(width: 340, height: 160)
                .clipped()

            LinearGradient(
                gradient: Gradient(colors: [.pageBlue.opacity(0.7), .clear]),
                startPoint: .leading,
                endPoint: .trailing
            )

            VStack(alignment: .leading, spacing: 20) {
                Text("오늘의 디깅 추천 List")
                    .font(.custom("Pretendard-Regular", size: 11))
                    .foregroundColor(.white)
                    .opacity(0.7)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.WidgetShadowColor.opacity(0.8))
                            .frame(width: 109, height: 27)
                            .shadow(color: .black.opacity(0.3), radius: 4, x: 2, y: 2)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.black.opacity(0.7), lineWidth: 4)
                                    .blur(radius: 2)
                                    .offset(x: 2, y: 2)
                                    .mask(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [.black, .clear]),
                                                    startPoint: .top,
                                                    endPoint: .bottom
                                                )
                                            )
                                    )
                            )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black.opacity(0.1), lineWidth: 1)
                            .frame(width: 109, height: 27)
                    )

                Spacer()

                HStack {
                    Image(brand.brandLogoImageName)
                        .resizable()
                        .frame(width: 25, height: 25)
                        .clipShape(Circle())

                    Text(brand.brandName)
                        .font(.custom("Pretendard-Medium", size: 20))
                        .foregroundColor(Color.lastTxt)
                }
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color.ProductBackGround)
                        .frame(width: 175, height: 35)
                        .opacity(0.5)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.gray, lineWidth: 1)
                        .frame(width: 175, height: 35)
                        .opacity(0.5)
                )
            }
            .padding()
        }
    }
}
