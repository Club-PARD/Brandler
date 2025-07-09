import SwiftUI

struct SearchBrandCardView: View {
    let brand: SearchBrand
    let width: CGFloat = 173
    let height: CGFloat = 252
    let cornerRadius: CGFloat = 12

    var body: some View {
        ZStack(alignment: .bottom) {
            // ✅ 배경 이미지 + 그라디언트
            ZStack {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: width, height: height)
                    .background(
                        Image(brand.brandBannerUrl)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width, height: height)
                    )
                    .cornerRadius(cornerRadius)
                
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("CardGradiantblack").opacity(0),
                        Color("CardGradiant").opacity(0.7)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(width: width, height: height)
                .cornerRadius(cornerRadius)
            }
            .clipped()
            
            // ✅ 로고 + 브랜드 이름
            VStack {
                Spacer()
                HStack(spacing: 6) {
                    Image(brand.brandLogoUrl)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .clipShape(Circle())
                        .offset(x: -7.5)
                    
                    Text(brand.name)
                        .font(.custom("Pretendard-Medium", size: 17))
                        .foregroundColor(Color("BrandNameColor"))
                        .lineLimit(1)
                }
                .frame(width: 147, height: 31)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("BrandGroupColor"))
                        .stroke(Color("BrandNameColor"), lineWidth: 2)
                )
                .padding(.bottom, 8)
            }
        }
        .frame(width: width, height: height)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}


//#Preview {
//    ZStack {
//        Color.black.ignoresSafeArea()
//        
//        SearchBrandCardView(brand: SearchBrand.sampleData[0])
//    }
//    .previewLayout(.sizeThatFits)
//}
