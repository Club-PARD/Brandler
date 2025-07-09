import SwiftUI

// 상품 카드의 앞면/뒷면을 전환하는 플립 카드 뷰
struct ItemFlipCardView: View {
    let item: Product1 // 표시할 상품 정보
    @Binding var flippedID: Int? // 현재 뒤집힌 카드의 ID

    @State private var rotation: Double = 0 // 회전 각도 상태

    // 현재 카드가 뒤집힌 상태인지 확인
    var isFlipped: Bool {
        flippedID == item.productID
    }

    var body: some View {
        ZStack {
            // 앞면 뷰 (보이는 조건: isFlipped가 false일 때)
            ItemCardFront(item: item)
                .opacity(isFlipped ? 0 : 1)
                .rotation3DEffect(Angle.degrees(rotation), axis: (x: 0, y: 1, z: 0))

            // 뒷면 뷰 (보이는 조건: isFlipped가 true일 때)
            ItemCardBack(item: item)
                .opacity(isFlipped ? 1 : 0)
                .rotation3DEffect(Angle.degrees(rotation + 180), axis: (x: 0, y: 1, z: 0))
        }
        .animation(.easeInOut(duration: 0.3), value: rotation) // 회전 애니메이션
        .onTapGesture {
            if isFlipped {
                flippedID = nil // 이미 열려있으면 닫기
            } else {
                flippedID = item.productID // 닫혀있으면 열기
            }
        }
        // 외부에서 flippedID가 변경되었을 때 회전 상태 동기화
        .onChange(of: flippedID) {
            if flippedID == item.productID {
                rotation = 180 // 내 카드가 열리면 회전
            } else {
                rotation = 0 // 다른 카드가 열리면 닫힘
            }
        }
    }
}
