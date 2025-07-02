import SwiftUI

struct BrandCardFront: View {
    let item: BrandItem

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                Image(item.frontImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 100)
                    .clipped()

                VStack {
                    Spacer()
                    Text(item.category.rawValue)
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blue)
            }

            Image(systemName: "tshirt")
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                .background(Circle().fill(Color.white))
                .offset(y: 80)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
    }
}

#Preview {
    BrandCardFront(item: BrandItem(
        frontImageName: "mockBanner1",
        name: "테스트 브랜드",
        price: 49000,
        category: .top
    ))
    .frame(width: 120, height: 180)
    .background(Color.gray)
}
