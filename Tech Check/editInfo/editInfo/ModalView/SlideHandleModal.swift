import SwiftUI

struct SlideHandleModal: View {
    @Binding var isExpanded: Bool
    @GestureState private var dragOffset: CGFloat = 0
    @State private var currentOffset: CGFloat = 0

    // 화면 높이 비율
    let collapsedHeight: CGFloat = 80
    let expandedHeightRatio: CGFloat = 0.7

    var body: some View {
        let screenHeight = UIScreen.main.bounds.height
        let expandedOffset = screenHeight * (1 - expandedHeightRatio)
        let collapsedOffset = screenHeight - collapsedHeight

        let offset = isExpanded ? expandedOffset : collapsedOffset

        VStack(spacing: 0) {
            // 핸들 표시
            Capsule()
                .fill(Color.gray.opacity(0.6))
                .frame(width: 40, height: 6)
                .padding(.top, 10)

            Text(isExpanded ? "위로 열린 모달" : "슬라이드 가능 모달")
                .font(.headline)
                .padding(.top, 4)

            if isExpanded {
                Divider().padding(.top, 4)

                ScrollView {
                    ForEach(0..<10) { i in
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue.opacity(0.2))
                            .frame(height: 100)
                            .overlay(Text("아이템 \(i)"))
                            .padding(.horizontal)
                            .padding(.top, 8)
                    }
                }
            }

            Spacer()
        }
        .frame(height: screenHeight) // 전체 뷰에 대해 드래그 처리
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .offset(y: offset + dragOffset)
        .gesture(
            DragGesture()
                .updating($dragOffset) { value, state, _ in
                    state = value.translation.height
                }
                .onEnded { value in
                    let threshold: CGFloat = 100
                    if value.translation.height < -threshold {
                        // 위로 드래그 → 열기
                        withAnimation(.spring()) {
                            isExpanded = true
                        }
                    } else if value.translation.height > threshold {
                        // 아래로 드래그 → 닫기
                        withAnimation(.spring()) {
                            isExpanded = false
                        }
                    } else {
                        // 원상 복귀
                        withAnimation(.spring()) {
                            isExpanded = isExpanded // 유지
                        }
                    }
                }
        )
        .animation(.easeInOut, value: isExpanded)
        .ignoresSafeArea(edges: .bottom)
    }
}
