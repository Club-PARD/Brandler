import SwiftUI

struct FirstBottomSheetView: View {
    @Binding var offsetY: CGFloat
    @GestureState var dragOffset: CGFloat

    var body: some View {
        GeometryReader { geometry in
            let screenHeight = geometry.size.height
            let maxHeight: CGFloat = screenHeight * 0.85
            let midHeight: CGFloat = 400
            let minHeight: CGFloat = 100

            VStack(spacing: 0) {
                Capsule()
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 40, height: 6)
                    .padding(.top, 10)

                if screenHeight + offsetY + dragOffset > 200 {
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(1...40, id: \.self) { index in
                                Text("Item \(index)")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .shadow(radius: 2)
                            }
                        }
                        .padding()
                    }
                } else {
                    VStack {
                        Text("리스트를 보려면 위로 올려주세요")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top, 20)
                        Spacer()
                    }
                }
            }
            .frame(width: geometry.size.width, height: maxHeight)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemBackground))
                    .shadow(radius: 10)
            )
            .offset(y: offsetY + dragOffset)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation.height
                    }
                    .onEnded { value in
                        let newOffset = offsetY + value.translation.height

                        let closed = screenHeight - minHeight
                        let mid = screenHeight - midHeight
                        let open = screenHeight - maxHeight

                        let closest = [closed, mid, open].min(by: {
                            abs(newOffset - $0) < abs(newOffset - $1)
                        }) ?? mid

                        withAnimation {
                            offsetY = closest
                        }
                    }
            )
            .onAppear {
                offsetY = screenHeight - minHeight
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
