import SwiftUI

// 상품 카드 앞면 뷰
struct ItemCardFront: View {
    let item: Product // 표시할 상품 정보

    var body: some View {
        // 상품 이미지를 표시
        Image(item.productImageUrl)
            .resizable() // 이미지 크기 조정 가능하게 설정
            .scaledToFill() // 프레임을 꽉 채우도록 비율 유지
            .frame(width: 120, height: 180) // 카드 크기 지정
            .clipped() // 프레임 바깥으로 넘치는 부분 잘라냄
            .clipShape(RoundedRectangle(cornerRadius: 12)) // 모서리 둥글게
            .shadow(radius: 2) // 그림자 효과
    }
}

// MARK: - Preview

#Preview {
    // 미리보기용 테스트 카드
    ItemCardFront(item: Product(
        productImageUrl: "level1 1",  // ⚠️ 실제 Assets에 있는 이미지 이름 필요
        name: "테스트 상품",           // 상품 이름
        price: 49000,                 // 상품 가격
        productCategory: .top         // 카테고리
    ))
}
