//import SwiftUI
//
//// ✅ 디깅한 브랜드 리스트를 보여주는 하단 모달 뷰
//struct FirstBottomSheetView: View {
//    @Binding var offsetY: CGFloat                    // 모달의 현재 위치 (외부에서 제어)
//    @GestureState var dragOffset: CGFloat            // 제스처 중인 위치 변화량 (드래그 중)
//    @ObservedObject var viewModel: BrandScrapeViewModel // 브랜드 데이터 ViewModel
//    @State private var flippedIndex: UUID? = nil     // 현재 플립된 카드의 UUID
//
//    var body: some View {
//        GeometryReader { geometry in
//            let screenHeight = geometry.size.height           // 전체 화면 높이
//            let maxHeight: CGFloat = screenHeight * 0.9       // 모달이 열렸을 때 최대 높이
//            let minHeight: CGFloat = 400// 모달이 닫혔을 때 높이 (시작 위치)
//
//            VStack(spacing: 0) {
//                // 🔹 상단 캡슐 모양 핸들 (드래그 유도)
//                Capsule()
//                    .fill(Color.gray.opacity(0.5))
//                    .frame(width: 40, height: 6)
//                    .padding(.top, 10)
//
//                // 🔹 모달 내용 스크롤 영역
//                ScrollView {
//                    Spacer().frame(height: 20)
//
//                    VStack(alignment: .center, spacing: 8) {
//                        // 타이틀
//                        Text("만나기 까지의 기록")
//                            .font(.system(size: 24))
//                            .foregroundColor(.white)
//
//                        // 서브 타이틀
//                        Text("내가 지금까지 디깅한 브랜드")
//                            .font(.system(size: 10))
//                            .foregroundColor(.white)
//
//                        Spacer().frame(height: 20)
//
//                        // 🔹 총 브랜드 개수 표시
//                        HStack {
//                            Text("총 \(viewModel.brands.count)개")
//                                .font(.system(size: 12))
//                                .foregroundColor(.white.opacity(0.7))
//                                .padding(.leading, 16)
//                            Spacer()
//                        }
//
//                        // 🔹 브랜드 카드 리스트 (3열 그리드)
//                        LazyVGrid(
//                            columns: [
//                                GridItem(.flexible(), spacing: 6),
//                                GridItem(.flexible(), spacing: 6),
//                                GridItem(.flexible(), spacing: 6)
//                            ],
//                            spacing: 16
//                        ) {
//                            ForEach(viewModel.brands) { brand in
//                                FlipCardView(
//                                    brand: brand,
//                                    flippedID: $flippedIndex,         // 플립 상태 유지
//                                    onDelete: {
//                                        viewModel.deleteBrand(brand)  // 삭제 시 ViewModel 처리
//                                    }
//                                )
//                                .frame(width: 120, height: 150)       // 카드 크기 지정
//                            }
//                        }
//                        .padding(.horizontal, 16)                     // 좌우 여백
//                    }
//                    .padding(.bottom, 30)                              // 아래 여백
//                }
//            }
//            // 🔹 모달 전체 프레임 크기
//            .frame(width: geometry.size.width, height: maxHeight)
//            
//            // 🔹 배경 설정 (둥근 테두리, 투명도, 그림자)
//            .background(
//                RoundedRectangle(cornerRadius: 30)
//                    .fill(Color(hex: "#63616066")) // 배경 색상 (투명도 포함된 hex)
//                    .opacity(0.4)
//                    .shadow(radius: 10)
//            )
//
//            // 🔹 현재 위치 반영하여 모달 위치 이동
//            .offset(y: offsetY + dragOffset)
//
//            // 🔹 드래그 제스처로 모달 이동 제어
//            .gesture(
//                DragGesture()
//                    .updating($dragOffset) { value, state, _ in
//                        state = value.translation.height
//                    }
//                    .onEnded { value in
//                        let newOffset = offsetY + value.translation.height
//
//                        // 가능한 위치 범위 정의 (열림/닫힘)
//                        let open = screenHeight - maxHeight
//                        let closed = screenHeight - minHeight
//
//                        // 열린 위치와 닫힌 위치 중 가까운 쪽으로 이동
//                        let closest = abs(newOffset - open) < abs(newOffset - closed) ? open : closed
//
//                        withAnimation {
//                            offsetY = closest
//                        }
//                    }
//            )
//
//            // 🔹 처음 로드될 때 닫힌 위치로 세팅
//            .onAppear {
//                offsetY = screenHeight - minHeight
//            }
//        }
//        .edgesIgnoringSafeArea(.bottom) // 하단 영역까지 확장
//    }
//}
//
//// MARK: - Preview용 Wrapper (개발자 테스트용)
//struct FirstBottomSheetPreviewWrapper: View {
//    @State private var offsetY: CGFloat = 0                     // 모달 위치 상태
//    @GestureState private var dragOffset: CGFloat = 0          // 제스처 중 드래그 변화량
//    @StateObject private var viewModel = BrandScrapeViewModel() // ViewModel 인스턴스
//
//    var body: some View {
//        ZStack {
//            // 배경 설정
//            Color.black.opacity(0.6).ignoresSafeArea()
//            Image("ScrapeBackground")
//                .edgesIgnoringSafeArea(.all)
//
//            // 실제 모달 표시
//            FirstBottomSheetView(
//                offsetY: $offsetY,
//                dragOffset: dragOffset,
//                viewModel: viewModel
//            )
//        }
//    }
//}
//
//// ✅ Xcode Preview 지원
//#Preview {
//    FirstBottomSheetPreviewWrapper()
//}
