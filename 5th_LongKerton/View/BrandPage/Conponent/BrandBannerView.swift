import SwiftUI // SwiftUI 프레임워크를 가져옵니다. UI를 선언적으로 구축하는 데 필요합니다.

/// `BrandBannerView`는 브랜드 배너를 표시하는 SwiftUI 뷰입니다.
/// 스크롤에 따라 회전하고 크기가 변하는 '구멍' 효과를 통해
/// 블러 처리된 배너와 선명한 배너 사이를 전환하는 시각적 효과를 구현합니다.
struct BrandBannerView: View {
    // 뷰모델을 환경객체로 받아와서 상태와 계산된 값을 사용합니다.
    // `@EnvironmentObject`는 뷰 계층 구조에서 상위 뷰가 제공하는 공유 객체를 주입받을 때 사용합니다.
    @EnvironmentObject var viewModel: BrandViewModel
    
    let brand: Brand // 표시할 브랜드 데이터를 나타내는 속성입니다.

    // MARK: - Body

    var body: some View {
        // `GeometryReader`를 사용하여 뷰의 컨테이너 크기와 좌표를 동적으로 읽어옵니다.
        // 이는 배너 이미지와 구멍의 정확한 위치 및 크기 계산에 필수적입니다.
        GeometryReader { geo in
            // 여러 뷰를 겹쳐서 배치하기 위해 `ZStack`을 사용합니다.
            // 블러 처리된 이미지, 선명한 이미지, 그라디언트 오버레이, 그리고 구멍 외곽선이 겹쳐집니다.
            ZStack {
                // MARK: - Hole Sizing and Positioning Calculations

                // 구멍 모양의 너비와 높이를 뷰모델에서 가져와 변수에 할당합니다.
                let holeWidth = viewModel.holeSize.width
                let holeHeight = viewModel.holeSize.height

                // ContentView(또는 부모 뷰)를 기준으로 구멍의 X축 오프셋을 계산합니다.
                // - `geo.size.width / 2`: `GeometryReader`의 중앙 (뷰의 중앙)
                // - `+ 61`: 특정 디자인 오프셋 (오른쪽으로 이동)
                // - `+ holeWidth / 2`: 구멍의 좌측 끝이 아닌 중앙을 기준으로 하기 위함
                // - `- 75`: 추가적인 왼쪽 이동 조정
                let offsetX = -geo.size.width / 2 + 61 + holeWidth / 2 - 75
                
                // 구멍의 Y축 오프셋을 뷰모델에서 가져옵니다.
                // 이 값은 스크롤 위치에 따라 동적으로 변하여 구멍이 위아래로 움직이는 효과를 만듭니다.
                let offsetY = viewModel.offsetYForScroll

                // MARK: - Layer 1: Sharp Banner Image (Base Layer)

                // 1️⃣ 아래 레이어: 선명한 배너 이미지
                // 이 이미지는 배경으로 깔리며, 블러 처리된 이미지의 '구멍'을 통해 보입니다.
                Image(brand.brandBannerUrl) // 실제 앱에서는 `Brand` 모델에서 이미지 이름을 받아옵니다.
                    .resizable()            // 이미지의 크기를 조절할 수 있도록 설정합니다.
                    .scaledToFill()         // 프레임에 꽉 차도록 이미지의 비율을 유지하며 확대/축소합니다.
                    .frame(height: viewModel.bannerHeight) // 뷰모델에서 정의된 고정 높이를 적용합니다.
                    .clipped()              // 프레임을 벗어나는 이미지 부분을 잘라냅니다.

                // MARK: - Layer 2: Blurred Banner Image with Hole Mask

                // 2️⃣ 위에 덮는 블러 처리된 배너 이미지 + 구멍 모양 마스크 적용
                // 이 이미지는 위 레이어에 놓이며, `RotatingRectHole` 마스크를 통해 특정 영역이 투명해집니다.
                Image(brand.brandBannerUrl) // 동일한 이미지를 사용하여 블러 효과를 만듭니다.
                    .resizable()
                    .scaledToFill()
                    .frame(height: viewModel.blurredBannerHeight) // 뷰모델에서 정의된 더 큰 높이를 설정합니다.
                    // 이미지의 Y 오프셋을 위로 이동시켜 블러 이미지가 선명한 배너 이미지와 자연스럽게 겹치고
                    // 구멍이 올바른 위치에 오도록 조정합니다.
                    .offset(y: -(viewModel.blurredBannerHeight - viewModel.bannerHeight) / 2)
                    .blur(radius: 10)       // 10포인트의 블러 효과를 적용하여 이미지를 흐리게 만듭니다.
                    .mask(                  // `mask` 수식어를 사용하여 특정 도형으로 뷰의 투명도를 정의합니다.
                        Rectangle() // 기본적으로 전체를 덮는 사각형 마스크를 사용합니다.
                            .overlay(       // 이 사각형 위에 다른 뷰를 겹쳐서 마스크의 형태를 조작합니다.
                                // `RotatingRectHole` 뷰를 오버레이로 추가합니다.
                                // 이 구멍 모양이 `blendMode(.destinationOut)`과 결합하여 '구멍' 역할을 합니다.
                                RotatingRectHole(
                                    angle: viewModel.angleForScroll, // 스크롤에 따라 변하는 구멍의 회전 각도
                                    offsetX: offsetX,               // 계산된 구멍의 X축 중심 위치
                                    offsetY: offsetY - 30,          // 계산된 구멍의 Y축 중심 위치 (추가 조정값 포함)
                                    holeWidth: holeWidth,           // 구멍의 너비
                                    holeHeight: holeHeight          // 구멍의 높이
                                )
                                .blendMode(.destinationOut) // 이 블렌드 모드는 오버레이된 뷰(RotatingRectHole)의 불투명 영역이
                                                            // 마스크의 기본 뷰(Rectangle)에서 '빼내는' 효과를 만듭니다.
                                                            // 결과적으로 이 구멍 영역만 투명해져 아래 선명한 이미지가 보입니다.
                            )
                            .compositingGroup() // `blendMode`가 여러 레이어에 걸쳐 올바르게 적용되려면
                                                // 해당 내용을 단일 오프스크린 렌더링 패스로 그룹화해야 합니다.
                    )

                // MARK: - Gradient Overlay

                // 🔹 선명한 이미지 위에 덮는 그라디언트 오버레이 (밝기 점진적 감소)
                // 배너 하단으로 갈수록 어두워지는 효과를 줍니다.
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.BgColor.opacity(0.0), // 그라디언트 상단은 완전 투명 (배경색 기준)
                        Color.BgColor.opacity(1.0)  // 그라디언트 하단은 완전 불투명 (배경색 기준)
                    ]),
                    startPoint: .top,               // 위에서 시작
                    endPoint: .bottom               // 아래로 끝남
                )
                .frame(height: viewModel.bannerHeight) // 배너의 고정 높이만큼 그라디언트 크기를 지정합니다.

                // MARK: - Layer 3: Rotating Hole Outline

                // 3️⃣ 구멍 모양의 회전하는 사각형 외곽선 그리기
                // 블러 처리된 이미지 위에 구멍의 경계를 시각적으로 강조하는 외곽선을 그립니다.
                RotatingRectHole(
                    angle: viewModel.angleForScroll, // 구멍의 회전 각도 (블러 마스크와 동일)
                    offsetX: offsetX,               // 구멍의 X축 중심 위치 (블러 마스크와 동일)
                    offsetY: offsetY - 30,          // 구멍의 Y축 중심 위치 (블러 마스크와 동일)
                    holeWidth: holeWidth,           // 구멍의 너비 (블러 마스크와 동일)
                    holeHeight: holeHeight          // 구멍의 높이 (블러 마스크와 동일)
                )
                // `stroke` 수식어를 사용하여 도형의 외곽선만 그립니다.
                .stroke(Color.white.opacity(0.5), lineWidth: 2) // 흰색 50% 불투명도, 2pt 두께의 선으로 그립니다.
                
                // 애니메이션 처리 주석 처리됨 (필요하면 활성화 가능)
                // `.animation(.easeInOut(duration: 0.3), value: viewModel.angleForScroll)`
                // 이 줄은 주석 처리되어 있지만, 만약 구멍의 회전 각도(`angleForScroll`)가 변할 때
                // 이 외곽선에만 별도의 애니메이션을 적용하고 싶다면 주석을 해제할 수 있습니다.
            }
            .frame(height: viewModel.bannerHeight) // `ZStack` 전체의 높이를 뷰모델의 배너 높이로 제한합니다.
            .clipped() // 이 프레임을 벗어나는 모든 내용(특히 블러 이미지의 추가 높이)을 잘라냅니다.
        }
    }
}
