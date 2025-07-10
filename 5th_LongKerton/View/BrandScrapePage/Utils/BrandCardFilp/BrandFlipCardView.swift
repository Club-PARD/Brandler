import SwiftUI

struct BrandFlipCardView: View {
    let brand: BrandCard
    @Binding var flippedID: Int?
    let onDelete: () -> Void
    let onShop: () -> Void
    @State private var rotation: Double = 0

    var isFlipped: Bool {
        flippedID == brand.brandId
    }

    var body: some View {
        ZStack {
            BrandCardFront(brand: brand)
                .opacity(isFlipped ? 0 : 1)
                .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))

            BrandCardBack(
                brand: brand,
                onDelete: {
                    // ✅ 삭제 전 flip 초기화
                    withAnimation {
                        rotation = 0
                        flippedID = nil
                    }

                    // 약간의 딜레이 후 실제 삭제
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        onDelete()
                    }
                },
                onShop: onShop
            )
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
                    flippedID = brand.brandId
                    rotation = 180
                }
            }
        }
        .onChange(of: flippedID) { _, newValue in
            if newValue != brand.brandId {
                withAnimation {
                    rotation = 0
                }
            }
        }
        .onChange(of: brand.brandId) { _, _ in
            rotation = 0
        }
        .transition(.asymmetric(insertion: .scale, removal: .opacity)) // ✅ 삭제/추가 애니메이션
    }
}

