import SwiftUI

// 브랜드 상세 페이지 뷰
struct BrandPage: View {
    @StateObject private var viewModel = BrandViewModel() // ViewModel 상태 객체
    @State private var scrollProxy: ScrollViewProxy? = nil // ScrollView 제어용 proxy

    var brand: Brand // 보여줄 브랜드 정보

    var body: some View {
        ZStack(alignment: .top) { // 최상단 정렬 ZStack
            Color.BgColor.ignoresSafeArea() // 전체 배경 색상 설정

            ScrollViewReader { proxy in // 스크롤 위치 제어를 위한 ScrollViewReader
                ScrollView { // 메인 스크롤 뷰
                    VStack(spacing: 0) { // 콘텐츠 수직 스택
                        Color.clear.frame(height: 0).id("top") // 스크롤 최상단 위치용 아이디

                        // 배너 뷰 및 스크롤 오프셋 추적
                        GeometryReader { geo in
                            BrandBannerView(brand: brand) // 브랜드 배너 뷰
                                .frame(height: viewModel.bannerHeight) // 배너 높이 지정
                                .background(
                                    Color.clear
                                        .preference(
                                            key: ScrollOffsetKey.self,
                                            value: -geo.frame(in: .named("scroll")).minY // y값으로 오프셋 계산
                                        )
                                )
                        }
                        .frame(height: viewModel.bannerHeight) // 외부에서 프레임 고정

                        // 스크롤 오프셋 변경 감지하여 ViewModel에 반영
                        .onPreferenceChange(ScrollOffsetKey.self) { offset in
                            viewModel.updateScrollOffset(offset)
                        }

                        // 브랜드 로고 + 이름 오버레이
                        BrandInfoOverlayView(
                            scrollOffset: viewModel.scrollOffset, // 스크롤 오프셋 전달
                            bannerHeight: viewModel.bannerHeight, // 배너 높이 전달
                            brand: brand // 브랜드 정보 전달
                        )
                        .offset(x: 15, y: overlayOffset + 250) // 위치 오프셋 설정
                        .padding(.top, -viewModel.bannerHeight + 40) // 배너와의 간격 조정
                        .animation(.easeInOut(duration: 0.25), value: overlayOffset) // 애니메이션 적용

                        // 본문 콘텐츠 영역
                        VStack(spacing: 0) {
                            Rectangle().fill(Color.BgColor).frame(height: 30) // 배너 아래 여백

                            CategoryTabBarView(selected: $viewModel.selectedCategory) // 카테고리 탭바
                                .padding(.vertical, 12) // 위아래 여백
                                .frame(height: 60) // 탭바 높이
                                .frame(maxWidth: .infinity) // 너비 최대
                                .background(Color.BgColor) // 배경색 설정

                            ItemGridView().padding(.bottom, 50) // 상품 목록

                            Text("Fashions fade, style is eternal. \n – Yves Saint Laurent") // 인용구
                                .font(.custom("Pretendard-Regular", size: 12))
                                .foregroundColor(Color.TabPurple)
                                .multilineTextAlignment(.center) // 중앙 정렬

                            Spacer(minLength: 200) // 하단 여백
                        }
                        .offset(y: tabGroupOffset) // 전체 콘텐츠 오프셋
                        .animation(.easeInOut(duration: 0.25), value: tabGroupOffset) // 오프셋 애니메이션
                    }
                }
                .coordinateSpace(name: "scroll") // 스크롤 좌표계 이름 지정
                .onAppear { scrollProxy = proxy } // ScrollProxy 저장
            }

            // 최상단 고정 탭바 (뒤로가기 포함)
            TopTabBarView(
                tabBarScrollOffset: viewModel.tabBarScrollOffset, // 탭바 위치 제어용 오프셋
                brandName: brand.name, // 브랜드 이름
                backAction: {
                    print("뒤로가기 탭됨") // 뒤로가기 동작 (추후 Navigation 처리 가능)
                }
            )
            .offset(y: -85) // 상단 위치 조정
            .zIndex(1000) // 가장 위에 렌더링되도록 설정

            // 스크롤 맨 위로 이동 버튼
            ScrollToTopButton(
                proxy: scrollProxy, // ScrollProxy 사용
                visible: viewModel.scrollOffset > 200 // 오프셋 200 이상일 때만 표시
            )
            .offset(y: -70) // 위치 조정
        }
        .environmentObject(viewModel) // ViewModel을 자식 뷰에 주입
        .navigationBarBackButtonHidden(true) // 기본 뒤로가기 버튼 숨김
    }

    // 브랜드 정보 오버레이 위치 계산
    var overlayOffset: CGFloat {
        min(viewModel.scrollOffset, 170) // 170까지 고정 위치, 이후 따라감
    }

    // 콘텐츠 그룹 전체 오프셋 계산
    var tabGroupOffset: CGFloat {
        min(viewModel.scrollOffset, 170) // 170까지만 이동
    }

    // 탭바 위치 계산 (카테고리 탭바가 움직이는 로직에 사용 가능)
    var tabBarOffset: CGFloat {
        let offset = viewModel.categoryTabBarScrollOffset
        if offset <= 300 {
            return offset
        } else if offset <= 665 {
            return 600 - (665 - offset)
        } else {
            return 600
        }
    }
}

// MARK: - 프리뷰용 Brand 샘플
extension Brand {
    static let preview: Brand = Brand(
        id: UUID(),
        name: "샘플 브랜드",
        brandGenre: "캐주얼",
        description: "이 브랜드는 모던한 감성의 캐주얼 아이템을 선보입니다.",
        brandBannerUrl: "mockBanner1",
        brandLogoUrl: "mockLogo1",
//        isScraped: true,
        brandHomePageUrl: "https://www.samplebrand.com",
        brandLevel: 3
    )
}

// MARK: - BrandPage 프리뷰
#Preview {
    BrandPage(brand: .preview)
}
