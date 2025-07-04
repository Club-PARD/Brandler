import SwiftUI

struct ItemCardFront: View {
    let item: BrandItem

    var body: some View {
        Image("level1")
            .resizable()
            .scaledToFill()
            .frame(width: 120, height: 180)  // 원한다면 크기 고정
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 2)
    }
}

//#Preview {
//    BrandCardFront(item: BrandItem(
//        frontImageName: "mockBanner1",
//        name: "테스트 브랜드",
//        price: 49000,
//        category: .top
//    ))
//    // 여기서 크기 프레임은 위에서 지정했으니 선택 사항
//}
