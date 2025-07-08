import SwiftUI // SwiftUI 프레임워크 임포트
struct BrandFlipCardView: View {
    let brand: Brand
    @Binding var flippedID: UUID?
    let onDelete: () -> Void
    let onShop: () -> Void
    @State private var rotation: Double = 0

    var isFlipped: Bool {
        flippedID == brand.id
    }

    var body: some View {
        ZStack {
            BrandCardFront(brand: brand)
                .opacity(isFlipped ? 0 : 1)
                .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))

            BrandCardBack(brand: brand, onDelete: onDelete, onShop: onShop)
                .opacity(isFlipped ? 1 : 0)
                .rotation3DEffect(.degrees(rotation + 180), axis: (x: 0, y: 1, z: 0))
        }
        .animation(.easeInOut(duration: 0.3), value: rotation)
        .onTapGesture {
            if isFlipped {
                withAnimation {
                    rotation = 0
                    flippedID = nil
                }
            } else {
                withAnimation {
                    flippedID = brand.id
                    rotation = 180
                }
            }
        }
        .onChange(of: flippedID) { _, newValue in
            if newValue != brand.id {
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
