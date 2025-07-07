import SwiftUI

struct ItemCardFront: View {
    let item: Product

    var body: some View {
        Image(item.productImageUrl)
            .resizable()
            .scaledToFill()
            .frame(width: 120, height: 180)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 2)
    }
}

// MARK: - Preview

#Preview {
    ItemCardFront(item: Product(
        productImageUrl: "level1 1",  // ⚠️ 실제 이미지 이름 사용
        name: "테스트 상품",
        price: 49000,
        productCategory: .top
    ))
}
