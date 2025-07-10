import SwiftUI

// 상품 카드의 뒷면 뷰
struct ItemCardBack: View {
    let item: Product // 상품 정보
    
    @State private var showDeleteAlert = false // 삭제 알림창 표시 여부 상태
    
    var body: some View {
        ZStack {
            // 배경 이미지
            Image(item.productImageName)
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 168) // 카드 크기 지정

            // 반투명 그라데이션
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.Gradient2,
                    Color.pageBlue,
                    Color.pageBlue
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .opacity(0.7)

            // 중앙 텍스트
            VStack(spacing: 8) {
                Text(item.productName)
                    .font(.custom("Pretendard-Regular", size: 12))
                    .foregroundColor(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.ProductBackGround) // 배경색
                            .frame(width: 81, height: 16)
                            .opacity(0.5)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white, lineWidth: 1) // 테두리
                            .frame(width: 81, height: 16)
                            .opacity(0.5)
                    )

                Text("KRW \(item.price)")
                    .font(.custom("Pretendard-Regular", size: 10))
                    .foregroundColor(.white)
            }
            .multilineTextAlignment(.center)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(radius: 2)
    }
}
//
//#Preview {
//    ZStack {
//        Color.black.ignoresSafeArea() // 어두운 배경 설정
//        ItemCardBack(item: Product1.brandItems.first!) {
//            print("🗑️ 삭제 실행됨")
//        }
//        .frame(width: 160, height: 240) // 카드 크기
//        .padding()
//    }
//}
