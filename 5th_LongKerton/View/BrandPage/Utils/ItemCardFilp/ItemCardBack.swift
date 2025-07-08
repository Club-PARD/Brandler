import SwiftUI

// 상품 카드의 뒷면 뷰
struct ItemCardBack: View {
    let item: Product // 상품 정보
    let onDelete: () -> Void // 삭제 동작을 위한 클로저

    @State private var showDeleteAlert = false // 삭제 알림창 표시 여부 상태

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // 배경 색상 (반투명 회색)
            Color.gray.opacity(0.3)

            VStack(spacing: 8) {
                Spacer() // 위쪽 여백

                // 상품 이름
                Text(item.name)
                    .font(.custom("Pretendard-Regular", size: 12))
                    .foregroundColor(.white)

                // 상품 가격
                Text("\(item.price)원")
                    .font(.custom("Pretendard-Regular", size: 12))
                    .foregroundColor(.white)

                Spacer() // 아래쪽 여백
            }
            .padding() // 전체 내용에 패딩 적용
        }
        .clipShape(RoundedRectangle(cornerRadius: 8)) // 카드 모서리를 둥글게
        .shadow(radius: 2) // 그림자 효과
    }
}
