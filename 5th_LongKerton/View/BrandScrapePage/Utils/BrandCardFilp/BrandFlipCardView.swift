import SwiftUI // SwiftUI 프레임워크 임포트

// MARK: - 브랜드 플립 카드 뷰
struct BrandFlipCardView: View {
    let brand: Brand // 표시할 브랜드 정보
    @Binding var flippedID: UUID? // 현재 뒤집힌 카드의 ID (외부에서 제어)
    var onDelete: () -> Void // 삭제 버튼 액션
    
    @State private var rotation: Double = 0 // 현재 회전 각도 상태

    // 현재 카드가 뒤집힌 상태인지 여부 (flippedID와 ID 비교)
    var isFlipped: Bool {
        flippedID == brand.id
    }

    var body: some View {
        ZStack {
            // 앞면 카드 (회전 안 된 상태)
            BrandCardFront(brand: brand)
                .opacity(isFlipped ? 0 : 1) // 뒤집힌 경우 숨김
                .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0)) // Y축 회전

            // 뒷면 카드 (회전 180도)
            BrandCardBack(brand: brand, onDelete: onDelete)
                .opacity(isFlipped ? 1 : 0) // 뒤집힌 경우 보임
                .rotation3DEffect(.degrees(rotation + 180), axis: (x: 0, y: 1, z: 0)) // 180도 회전
        }
        // 회전에 따라 애니메이션 적용
        .animation(.easeInOut(duration: 0.3), value: rotation)

        // 탭 제스처로 카드 앞/뒤 전환
        .onTapGesture {
            if isFlipped {
                // 이미 뒤집힌 상태면 원래대로 되돌림
                withAnimation {
                    rotation = 0
                    flippedID = nil
                }
            } else {
                // 다른 카드가 열려있다면 닫고, 이 카드 뒤집기
                withAnimation {
                    flippedID = brand.id
                    rotation = 180
                }
            }
        }

        // 외부에서 flippedID가 바뀌었을 때 카드 상태도 초기화
        .onChange(of: flippedID) { _, newValue in
            if newValue != brand.id {
                // 이 카드가 아닌 경우 다시 앞면으로 회전
                withAnimation {
                    rotation = 0
                }
            }
        }
    }
}

// MARK: - 프리뷰 예시 (주석 처리됨)
//#Preview {
//    StatefulPreviewWrapper(nil) { flippedID in
//        BrandFlipCardView(
//            brand: MockBrand(
//                id: UUID(),
//                name: "테스트 브랜드",
//                genre: "힙합",
//                description: "설명입니다.",
//                bannerImageName: "mockBanner1",
//                logoImageName: "mockLogo1"
//            ),
//            flippedID: flippedID,
//            onDelete: { print("삭제됨") }
//        )
//        .frame(width: 120, height: 180)
//        .background(Color.gray)
//    }
//}
