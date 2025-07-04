import SwiftUI

struct BrandBannerView: View {
    // 뷰모델을 환경객체로 받아와서 상태와 계산된 값을 사용
    @EnvironmentObject var viewModel: BrandPageViewModel

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // 구멍 모양 크기 변수로 할당 (뷰모델에서 가져옴)
                let holeWidth = viewModel.holeSize.width
                let holeHeight = viewModel.holeSize.height

                // ContentView 기준 좌표 계산
                // 구멍 중심 X 좌표 (기준 화면 너비 절반에서 좌우 위치 조정)
                let offsetX = -geo.size.width / 2 + 61 + holeWidth / 2 - 75
                // 구멍 중심 Y 좌표 (스크롤에 따른 오프셋 조정)
                let offsetY = viewModel.offsetYForScroll

                // 1️⃣ 아래 레이어: 선명한 배너 이미지
                Image("brandBanner") // 실제 앱에서는 모델에서 이미지명 받아옴
                    .resizable()      // 크기 조절 가능하도록 설정
                    .scaledToFill()   // 프레임에 꽉 차도록 비율 유지하며 확대/축소
                    .frame(height: viewModel.bannerHeight) // 고정 높이 적용
                    .clipped()        // 프레임 넘치는 부분 잘라내기
                
                // 2️⃣ 위에 덮는 블러 처리된 배너 이미지 + 구멍 모양 마스크 적용
                Image("brandBanner") // 동일한 이미지, 블러용
                    .resizable()
                    .scaledToFill()
                    .frame(height: viewModel.blurredBannerHeight) // 더 큰 높이로 설정
                    // 이미지 Y 오프셋을 위로 이동시켜 블러 이미지가 배너 이미지와 자연스럽게 겹치게 함
                    .offset(y: -(viewModel.blurredBannerHeight - viewModel.bannerHeight) / 2)
                    .blur(radius: 10) // 블러 효과 적용
                    .mask(           // 마스크를 통해 구멍 모양 영역만 투명 처리
                        Rectangle()
                            .overlay(
                                // 구멍 모양 뷰를 blendMode로 빼내기(destinationOut) 처리해 구멍처럼 보이도록 함
                                RotatingRectHole(
                                    angle: viewModel.angleForScroll,  // 구멍의 회전 각도
                                    offsetX: offsetX,                  // 구멍 중심 X 위치
                                    offsetY: offsetY - 30,             // 구멍 중심 Y 위치 (조정값 포함)
                                    holeWidth: holeWidth,              // 구멍 가로 크기
                                    holeHeight: holeHeight             // 구멍 세로 크기
                                )
                                .blendMode(.destinationOut)         // '구멍 뚫기' 효과를 위해 필요한 블렌드 모드
                            )
                            .compositingGroup() // 컴포지팅 그룹 지정 (blendMode가 정상 작동하려면 필수)
                    )
                
                // 🔹 선명한 이미지 위에 덮는 그라디언트 오버레이 (밝기 점진적 감소)
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.BgColor.opacity(0.0),  // 위쪽은 투명
                        Color.BgColor.opacity(1.0)   // 아래쪽은 완전 불투명 검정
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: viewModel.bannerHeight) // 배너 높이만큼 크기 지정
                
                // 3️⃣ 구멍 모양의 회전하는 사각형 외곽선 그리기
                RotatingRectHole(
                    angle: viewModel.angleForScroll, // 구멍 회전 각도
                    offsetX: offsetX,                 // 구멍 중심 X 위치
                    offsetY: offsetY - 30,            // 구멍 중심 Y 위치 (조정 포함)
                    holeWidth: holeWidth,             // 구멍 가로 크기
                    holeHeight: holeHeight            // 구멍 세로 크기
                )
                .stroke(Color.white.opacity(0.5), lineWidth: 2) // 흰색 반투명 선으로 외곽선 그림
                // 애니메이션 처리 주석 처리됨 (필요하면 활성화 가능)
//                .animation(.easeInOut(duration: 0.3), value: viewModel.angleForScroll)
            }
            .frame(height: viewModel.bannerHeight) // 전체 뷰 높이 지정
            .clipped()  // 프레임 벗어나는 부분 자르기
        }
    }
}

// MARK: - 미리보기용 Wrapper
#Preview {
    struct PreviewWrapper: View {
        @StateObject private var viewModel = BrandPageViewModel() // 뷰모델 생성 및 상태 관리
        @State private var sliderValue: CGFloat = 0                // 슬라이더 값으로 스크롤 위치 조절용

        var body: some View {
            VStack {
                BrandBannerView()       // 실제 배너 뷰
                    .environmentObject(viewModel) // 환경객체로 뷰모델 전달

                Slider(value: $sliderValue, in: 0...300) {  // 슬라이더로 스크롤 오프셋을 변경 가능
                    Text("Scroll Offset")
                }
                .padding()
                .onChange(of: sliderValue) { newValue in
                    viewModel.updateScrollOffset(newValue)  // 슬라이더 값 변경 시 뷰모델에 반영
                }

                // 디버깅용 텍스트: 현재 스크롤 위치와 회전 각도 출력
                Text("scrollOffset: \(Int(sliderValue)) / angle: \(Int(viewModel.angleForScroll.degrees))°")
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .background(Color.black)  // 배경 검정색으로 설정
        }
    }

    return PreviewWrapper()
}
