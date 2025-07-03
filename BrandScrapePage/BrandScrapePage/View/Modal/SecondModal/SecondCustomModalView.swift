import SwiftUI
// ✅ 메인 모달 뷰
struct SecondModalView: View {
    @Binding var isVisible: Bool // 모달 표시 여부
    @GestureState private var dragOffset: CGFloat = 0 // 드래그 실시간 변화량
    @State private var offsetY: CGFloat = UIScreen.main.bounds.height // 현재 위치 상태
    @State private var selectedTab = 0 // 선택된 탭 인덱스
    @StateObject private var viewModel = BrandScrapeViewModel() // 브랜드 데이터
    
    var body: some View {
        GeometryReader { geometry in
            let screenHeight = geometry.size.height
            let maxHeight = screenHeight * 0.95 // 모달 최대 높이
            let openOffset = screenHeight - maxHeight // 최상단 위치
            let closeThreshold = screenHeight * 0.6 // 드래그로 닫히는 기준
            
            ZStack {
                // ✅ 반투명 뒷배경
                if isVisible {
                    Color.black.opacity(0.6)
                        .ignoresSafeArea()
                        .onTapGesture {
                            slideDownAndClose(to: screenHeight)
                        }
                    
                    VStack(spacing: 0) {
                        // ✅ 상단 닫기 버튼
                        HStack {
                            Button(action: {
                                slideDownAndClose(to: screenHeight)
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            Spacer()
                        }
                        
                        // ✅ 타이틀 영역
                        VStack(spacing: 4) {
                            Text("단계 가이드")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        .padding(.bottom, 12)
                        
                        // ✅ 콘텐츠 영역
                        ScrollView {
                            VStack(spacing: 0) {
                                // ✅ 탭 버튼
                                HStack(spacing: 8) {
                                    TabButton(title: "디깅러 가이드", selected: selectedTab == 0) {
                                        selectedTab = 0
                                    }

                                    TabButton(title: "브랜드 가이드", selected: selectedTab == 1) {
                                        selectedTab = 1
                                    }
                                }
                                .padding(.horizontal, 25)
                                .frame(height: 56)
                                .padding(.top, 20)
                                // ✅ 콘텐츠 설명 + 단계 카드
                                VStack(spacing: 16) {
                                    Text(selectedTab == 0 ?
                                         "디깅러들은 브랜드를 스크랩 할수록 브랜드와 만남" :
                                            "브랜드는 스크랩 수에 따라 성장함")
                                    .font(.system(size: 8))
                                    .foregroundColor(.black)
                                    
                                    VStack(spacing: 24) {
                                        if selectedTab == 0 {
                                            ForEach(1...5, id: \.self) { step in
                                                DiggingStepView(
                                                    step: step,
                                                    progress: viewModel.progress(for: step),
                                                    diggingDistanceInKM: viewModel.diggingDistanceInKM
                                                )
                                            }
                                        } else {
                                            ForEach(1...5, id: \.self) { step in
                                                BrandStepView(step: step)
                                            }
                                        }
                                    }
                                }
                                .padding()
                                .background(Color(hex: "#C4D1FF").opacity(0.6))
                                .mask(
                                    CustomRoundedCorner(
                                        radius: 16,
                                        corners: {
                                            var result: [Corner] = [.bottomLeft, .bottomRight]
                                            if selectedTab == 0 {
                                                result.append(.topRight)
                                            } else {
                                                result.append(.topLeft)
                                            }
                                            return result
                                        }()
                                    )
                                )
                                

                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 25)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .ignoresSafeArea(.container, edges: .bottom)
                        Spacer()
                    }
                    .frame(width: geometry.size.width - 19, height: maxHeight) // ✅ 크기 지정
                    .background(Color(hex: "#63616066").opacity(0.6)) // ✅ 배경색
                    .clipShape(RoundedRectangle(cornerRadius: 30)) // ✅ 모서리 둥글게
                    .offset(y: offsetY + dragOffset) // ✅ 애니메이션 위치
                    .gesture(
                        DragGesture()
                            .updating($dragOffset) { value, state, _ in
                                state = value.translation.height
                            }
                            .onEnded { value in
                                let newOffset = offsetY + value.translation.height
                                if newOffset > closeThreshold {
                                    slideDownAndClose(to: screenHeight)
                                } else {
                                    withAnimation { offsetY = openOffset }
                                }
                            }
                    )
                    .onAppear {
                        withAnimation { offsetY = openOffset } // 열릴 때 애니메이션
                    }
                    .transition(.move(edge: .bottom))
                    .zIndex(10)
                }
            }
            .ignoresSafeArea(.container, edges: .bottom)
        }
    }
    
    // ✅ 닫는 함수
    private func slideDownAndClose(to screenHeight: CGFloat) {
        withAnimation { offsetY = screenHeight }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isVisible = false
        }
    }
}


// ✅ 진행률 바 (ZStack 사용 안 함)
struct ProgressBarView: View {
    var progress: Double // 0.0 ~ 1.0
    
    var body: some View {
        GeometryReader { geo in
            let totalWidth = geo.size.width
            let filledWidth = totalWidth * progress
            
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color.black)
                    .frame(width: filledWidth)
                Spacer(minLength: 0)
            }
            .frame(height: 8)
            .background(Color(hex: "#D9D9D9"))
            .cornerRadius(4)
        }
        .frame(height: 8)
        .padding(.horizontal, 10)
    }
}

// ✅ 프리뷰용 Wrapper
struct SecondModalPreviewWrapper: View {
    @State private var isVisible = true
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6).ignoresSafeArea()
            Image("ScrapeBackground")
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
