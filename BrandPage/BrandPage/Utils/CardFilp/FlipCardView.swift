import SwiftUI

struct FlipCardView: View {
    let item: BrandItem
    @Binding var flippedID: UUID?
    var onDelete: () -> Void

    @State private var rotation: Double = 0

    var isFlipped: Bool {
        flippedID == item.id
    }

    var body: some View {
        ZStack {
            BrandCardFront(item: item)
                .opacity(isFlipped ? 0 : 1)
                .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))

            BrandCardBack(item: item, onDelete: onDelete)
                .opacity(isFlipped ? 1 : 0)
                .rotation3DEffect(.degrees(rotation + 180), axis: (x: 0, y: 1, z: 0))
        }
        .animation(.easeInOut(duration: 0.3), value: rotation)
        .onTapGesture {
            if isFlipped {
                rotation = 0
                flippedID = nil
            } else {
                rotation = 180
                flippedID = item.id
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var flippedID: UUID? = nil

        var body: some View {
            FlipCardView(
                item: BrandItem(
                    frontImageName: "mockBanner1",
                    name: "프리뷰 브랜드",
                    price: 59000,
                    category: .accessory
                ),
                flippedID: $flippedID,
                onDelete: { print("삭제됨") }
            )
            .frame(width: 120, height: 180)
            .background(Color.gray)
        }
    }

    return PreviewWrapper()
}
