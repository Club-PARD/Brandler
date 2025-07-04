import SwiftUI

// MARK: - 브랜드 페이지 뷰
struct BrandPage: View {
    // 🔹 ViewModel을 상태 객체로 선언하여 UI와 데이터 상태를 바인딩
    @StateObject private var viewModel = BrandPageViewModel()

    var body: some View {
        ZStack(alignment: .top) { // 🔸 전체 화면을 위 기준으로 ZStack 구성
            Color(hex: "#1B191A").ignoresSafeArea() // 🔸 배경을 블랙으로 설정하고 safe area 무시

            // MARK: - 콘텐츠 스크롤 뷰
            ScrollView {
                VStack(spacing: 0) {
                    // MARK: - 배너 뷰 (스크롤 오프셋 추적 포함)
                    GeometryReader { geo in
                        BrandBannerView() // 🔸 상단 브랜드 배너 이미지 뷰
                            .frame(height: viewModel.bannerHeight) // 고정 높이
                            .onAppear {
                                // 배너가 처음 나타날 때 현재 위치를 기록
                                viewModel.updateScrollOffset(-geo.frame(in: .named("scroll")).minY)
                            }
                            .onChange(of: geo.frame(in: .named("scroll")).minY) { newOffset in
                                // 스크롤 될 때마다 위치 변화 감지
                                viewModel.updateScrollOffset(-newOffset)
                            }
                    }
                    .frame(height: viewModel.bannerHeight) // GeometryReader도 같은 높이로 제한

                    // MARK: - 브랜드 오버레이 뷰 (스크롤에 따라 자연스럽게 이동)
                    BrandInfoOverlayView(
                        scrollOffset: viewModel.scrollOffset,
                        bannerHeight: viewModel.bannerHeight
                    )
                    .offset(x: +15) // 디자인상 약간 왼쪽 이동
                    .offset(y: overlayOffset+250) // 스크롤에 따른 y 위치 조정
                    .animation(.easeInOut(duration: 0.25), value: overlayOffset)
                    .padding(.top, -viewModel.bannerHeight + 40) // 배너 위에 올리기 + SafeArea 고려

                    // MARK: - 탭바 + 아이템 그리드
                    VStack(spacing: 0) {
                        // 🔸 카테고리 탭바
                        CategoryTabBarView(selected: $viewModel.selectedCategory)
//                            .padding(.horizontal)
                            .padding(.top, 12)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#1B191A"))

                        // 🔸 아이템 카드 목록
                        ItemGridView()
                            .padding(.bottom, 100) // 하단 공간 여유

                        // 🔸 추가적인 빈 공간 (스크롤 끝났을 때 여유 있게)
                        Spacer(minLength: 200)
                    }
                    .offset(y: tabGroupOffset) // 탭바+그리드 묶음에 오프셋 적용
                    .animation(Animation.easeInOut(duration: 0.25), value: tabGroupOffset)
                }
            }
            .coordinateSpace(name: "scroll") // 스크롤 위치 추적을 위한 네이밍
        }

        // MARK: - 디버그용 텍스트 (현재 스크롤 오프셋)
        .environmentObject(viewModel) // ViewModel 전역 공유

//        Text("ScrollOffset: \(Int(viewModel.scrollOffset))")
//            .foregroundColor(.white)
//            .padding(8)
//            .background(Color.red.opacity(0.7))
//            .cornerRadius(8)
//            .padding()
//            .zIndex(999) // 항상 맨 위에 떠 있도록 설정
    }

    // MARK: - 오버레이 오프셋 계산
    /// 스크롤 오프셋(scrollOffset)에 따라 브랜드 오버레이 뷰의 Y축 위치를 계산합니다.
    ///
    /// - offset이 0~170 사이일 때는 오프셋만큼 자연스럽게 아래로 이동합니다.
    /// - offset이 170을 초과하면, 오버레이는 고정된 위치에서 콘텐츠처럼 점점 위로 밀려 사라지는 방식으로 전환됩니다.
    /// - 278 - offset은 고정 위치 이후의 반전 계산으로, 서서히 사라지도록 만들기 위한 트릭입니다.
    var overlayOffset: CGFloat {
        let offset = viewModel.scrollOffset
        if offset <= 170 {
            return offset
        } else {
            return 170
        }
    }

    // MARK: - 탭바 오프셋 계산
    /// 스크롤 시 탭바와 그리드 전체가 아래로 살짝 밀리는 효과
    var tabGroupOffset: CGFloat {
        let offset = viewModel.scrollOffset
        if offset <= 170 {
            return offset
        } else {
            return 170
        }
    }
}

// MARK: - 프리뷰
#Preview {
    BrandPage()
}
