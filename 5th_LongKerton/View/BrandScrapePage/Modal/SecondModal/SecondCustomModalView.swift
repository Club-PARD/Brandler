
import SwiftUI

struct SecondModalView: View {
    @Binding var isVisible: Bool
    @GestureState private var dragOffset: CGFloat = 0
    @State private var offsetY: CGFloat = UIScreen.main.bounds.height
    @State private var selectedTab = 0
    @StateObject private var viewModel = BrandViewModel()

    var body: some View {
        GeometryReader { geometry in
            let screenHeight = geometry.size.height
            let maxHeight = screenHeight * 0.95
            let openOffset = screenHeight - maxHeight
            let closeThreshold = screenHeight * 0.6

            ZStack(alignment: .center) {
                if isVisible {
                    Color.black.opacity(0.6)
                        .ignoresSafeArea()
                        .onTapGesture {
                            slideDownAndClose(to: screenHeight)
                        }

                    modalContent(geometry: geometry, maxHeight: maxHeight, openOffset: openOffset, closeThreshold: closeThreshold)
                        .transition(.move(edge: .bottom))
                        .zIndex(10)
                }
            }
            .ignoresSafeArea(.container, edges: .bottom)
        }
    }

    private func modalContent(geometry: GeometryProxy, maxHeight: CGFloat, openOffset: CGFloat, closeThreshold: CGFloat) -> some View {
        VStack(spacing: 0) {
            closeButton
            modalTitle
            modalScrollContent
            Spacer()
        }
        .frame(width: geometry.size.width - 30, height: maxHeight)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.ModalBackground1,
                    Color.ModalBackground2,
                    Color.ModalBackground3
                ]),
                startPoint: .top,
                endPoint: .bottom
            ).opacity(0.2)
        )
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .offset(y: offsetY + dragOffset)
        .gesture(
            DragGesture()
                .updating($dragOffset) { value, state, _ in
                    state = value.translation.height
                }
                .onEnded { value in
                    let newOffset = offsetY + value.translation.height
                    if newOffset > closeThreshold {
                        slideDownAndClose(to: geometry.size.height)
                    } else {
                        withAnimation { offsetY = openOffset }
                    }
                }
        )
        .onAppear {
            withAnimation { offsetY = openOffset }
        }
    }

    private var closeButton: some View {
        HStack {
            Button(action: {
                slideDownAndClose(to: UIScreen.main.bounds.height)
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .padding()
            }
            Spacer()
        }
    }

    private var modalTitle: some View {
        Text("단계 가이드")
            .font(.custom("Pretendard-SemiBold", size: 15))
            .foregroundColor(.white)
            .padding(.bottom, 12)
            .offset(y: -25)
    }

    private var modalScrollContent: some View {
        ScrollView {
            VStack(spacing: 10) {
                tabSelector
                stepDescription
                stepCards
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 19)
            Spacer().frame(height: 150)
        }
        .ignoresSafeArea(.container, edges: .bottom)
    }

    private var tabSelector: some View {
        HStack(spacing: 8) {
            TabButton(title: "디깅러", selected: selectedTab == 0) {
                selectedTab = 0
            }
            TabButton(title: "브랜드", selected: selectedTab == 1) {
                selectedTab = 1
            }
        }
        .font(.custom("Pretendard-Medium", size: 12))
        .frame(height: 56)
        .padding(.top, 20)
        .foregroundColor(.white)
    }

    private var stepDescription: some View {
        Text(
            selectedTab == 0 ?
            "고래를 발견할수록 당신의 바다는 더 깊어집니다. \n 취향의 지도를 확장해 보세요." :
            "디깅 수에 따라 고래가 자라납니다."
        )
        .font(.custom("Pretendard-Medium", size: 12))
        .foregroundColor(Color.TabPurple)
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity)
    }

    private var stepCards: some View {
        VStack(spacing: 10) {
            ForEach(Array(1...5), id: \ .self) { step in
                VStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.LogBlue)
                        .frame(width: 360, height: 1)

                    if selectedTab == 0 {
                        DiggingStepView(
                            step: step,
                            progress: viewModel.progress(for: step),
                            diggingDistanceInKM: viewModel.diggingDistanceInKM
                        )
                    } else {
                        BrandStepView(step: step)
                    }
                }
            }
        }
        .background(Color.ContentBackground.opacity(0.6))
        .mask(
            CustomRoundedCorner(
                radius: 16,
                corners: selectedTab == 0 ? [.bottomLeft, .bottomRight, .topRight] : [.bottomLeft, .bottomRight, .topLeft]
            )
        )
        .overlay(stepBorderOverlay)
    }

    private var stepBorderOverlay: some View {
        GeometryReader { geo in
            let tabWidth: CGFloat = 160
            let tabPadding: CGFloat = 25
            let diggerOffset: CGFloat = -4
            let brandOffset: CGFloat = 6

            let (gapStartX, gapEndX): (CGFloat, CGFloat) = selectedTab == 0 ? (
                tabPadding + diggerOffset - 20,
                tabPadding + tabWidth + diggerOffset - 5
            ) : (
                geo.size.width - tabPadding - tabWidth + brandOffset + 5,
                geo.size.width - tabPadding + brandOffset + 19
            )

            return CustomRoundedCornerWithFixedGap(
                radius: 16,
                corners: selectedTab == 0 ? [.bottomLeft, .bottomRight, .topRight] : [.bottomLeft, .bottomRight, .topLeft],
                gapStartX: gapStartX,
                gapEndX: gapEndX
            )
            .stroke(Color.LogBlue, lineWidth: 1)
        }
    }

    private func slideDownAndClose(to screenHeight: CGFloat) {
        withAnimation { offsetY = screenHeight }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isVisible = false
        }
    }
}

struct SecondModalPreviewWrapper: View {
    @State private var isVisible = true

    var body: some View {
        ZStack {
            Image("whaleBackground")
                .resizable()
                .scaledToFit()
                .edgesIgnoringSafeArea(.all)

            Button("모달 열기") {
                isVisible = true
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)

            SecondModalView(isVisible: $isVisible)
        }
    }
}

#Preview {
    SecondModalPreviewWrapper()
}
