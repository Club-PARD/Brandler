import SwiftUI

struct ItemFlipCardView: View {
    let item: BrandItem
    @Binding var flippedID: UUID?
    var onDelete: () -> Void

    @State private var rotation: Double = 0

    var isFlipped: Bool {
        flippedID == item.id
    }

    var body: some View {
        ZStack {
            ItemCardFront(item: item)
                .opacity(isFlipped ? 0 : 1)
                .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))

            ItemCardBack(item: item, onDelete: onDelete)
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
                    flippedID = item.id
                    rotation = 180
                }
            }
        }
        .onChange(of: flippedID) { newID in
            if newID != item.id && rotation != 0 {
                withAnimation {
                    rotation = 0
                }
            }
        }
    }
}
