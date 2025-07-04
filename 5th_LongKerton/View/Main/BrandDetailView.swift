//import SwiftUI
//
//struct BrandScrapePage: View {
//    // 두 번째 모달 (탭 가이드 모달) 표시 여부
//    @State private var showSecondModal = false
//
//    // 첫 번째 모달 (리스트 모달) 위치 상태
//    @State private var offsetY: CGFloat = 0
//    @GestureState private var dragOffset: CGFloat = 0
//
//    // ViewModel: 디깅 거리, 고래 이미지 등 상태 관리
//    @StateObject private var viewModel = BrandScrapeViewModel()
//
//    var body: some View {
//        ZStack {
//            // 배경색 (연회색)
//            Color(hex: "#8f8f8f").ignoresSafeArea()
//                .opacity(0.4)
//            Image("ScrapeBackground")
//                .edgesIgnoringSafeArea(.all)
//
//            VStack {
//                // 타이틀
//                Spacer()
//                    .frame(height: 20) // 높이 20 고정 (수직 방향에서)
//                Text("My Digging List")
//                    .font(.system(size: 16))
//                    .foregroundColor(.black)
//                    .padding(.horizontal, 20)
//                    .padding(.top, 20)
//                    .padding(.bottom, 10)
//
//                Spacer()
//                    .frame(height: 100)
//                // 현재 위치 텍스트
//                Text("현재위치")
//                    .font(.system(size: 20))
//                    .foregroundColor(.white)
//
//                // 현재 거리 표시 (예: -4.5km)
//                Text("\(String(format: "-%.1f", viewModel.diggingDistanceInKM))km")
//                    .font(.system(size: 32))
//                    .foregroundStyle(.white)
//
//                // ✅ 현재 깊이에 따른 고래 이미지 표시
//                Image(viewModel.whaleImageName)
//                    .resizable()
//                    .frame(width: 100, height: 100)
//                    .id(viewModel.whaleImageName) // 이미지가 변경될 때 자동 리렌더링
//
//                // ✅ 두 번째 모달 열기 버튼
//                Button(action: {
//                    showSecondModal = true
//                }) {
//                    Text("단계 레벨 가이드 보기")
//                        .font(.system(size: 10))
//                        .foregroundColor(.gray)
//                        .underline()
//                }
//                .buttonStyle(.plain)
//                .padding(.bottom, 16)
//
//                // ✅ 다음 단계까지 남은 거리 안내
//                Text("다음 고래를 만나기까지 \(String(format: "-%.1f", viewModel.remainingDistance))km 남았어요")
//                    .font(.system(size: 15))
//                    .foregroundColor(.white)
//
//                Spacer()
//                Spacer()
//            }
//
//            // ✅ 첫 번째 모달 (브랜드 리스트 카드 뷰)
//            FirstBottomSheetView(
//                offsetY: $offsetY,           // 모달 위치 상태 전달
//                dragOffset: dragOffset,      // 드래그 변화량
//                viewModel: viewModel         // 공통 ViewModel 전달
//            )
//            .ignoresSafeArea()
//
//            // ✅ 두 번째 모달 (디깅러 / 브랜드 가이드 모달)
//            if showSecondModal {
//                SecondModalView(isVisible: $showSecondModal)
//            }
//        }
//        // 두 번째 모달 전환 시 애니메이션 부드럽게
//        .animation(.easeInOut, value: showSecondModal)
//
//        // 첫 번째 모달의 초기 위치 설정
//        .onAppear {
//            let screenHeight = UIScreen.main.bounds.height
//            offsetY = screenHeight - 100 // 하단에서 살짝 보이게 시작
//        }
//    }
//}
//
//// ✅ 프리뷰 설정
//#Preview {
//    BrandScrapePage()
//}
import SwiftUI

struct BrandDetailView: View {
    let brand: MockBrand
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 99, height: 124)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: .black.opacity(0), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.29, green: 0.44, blue: 1).opacity(0.7), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.51, y: 0.88)
                    )
                )
                .background(
                    Image(brand.bannerImageName)
                )
            HStack{
                Image(brand.logoImageName)
                    .clipShape(Circle())
                    .frame(width: 14, height: 14)
                    .background(.white)
                    .overlay(
                        Rectangle()
                            .stroke(.white.opacity(0.3), lineWidth: 1)
                    )
                Text("최대글자수세븐")
                    .font(Font.custom("Pretendard", size: 10))
                    .foregroundColor(Color(red: 0.63, green: 0.63, blue: 0.63))
                    .frame(minWidth: 64, maxWidth: 64, maxHeight: .infinity, alignment: .leading)
            }
            .frame(width: 81, height: 16, alignment: .leading)
            
        }
    }
}
