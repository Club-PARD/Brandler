import SwiftUI

enum Category: String, CaseIterable, Identifiable {
    case all = "전체"            // 전체 카테고리
    case top = "상의"            // 상의 카테고리
    case bottom = "하의"         // 하의 카테고리
    case accessory = "악세사리"  // 악세사리 카테고리

    var id: String { rawValue } // Identifiable 프로토콜 준수용 ID, 케이스 이름 문자열 반환
}

final class BrandPageViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var scrollOffset: CGFloat = 0                // 전체 스크롤 오프셋 (메인 뷰 스크롤 위치)
    @Published var debugScrollOffset: CGFloat = 0           // 디버깅용 스크롤 오프셋 (실제값 추적용)
    @Published var tabBarScrollOffset: CGFloat = 0           // 탭바 전용 스크롤 오프셋 (탭바 위치 제어용)
    @Published var categoryTabBarScrollOffset: CGFloat = 0   // 카테고리 탭바 전용 스크롤 오프셋 -> 이거를 기반으로 움직이게 만들기.
    @Published var selectedCategory: Category = .all         // 선택된 카테고리 (기본값: 전체)

    @Published var items: [BrandItem] = [                    // 브랜드 아이템 리스트 (샘플 데이터)
        .init(frontImageName: "sample1", name: "루즈핏 후드", price: 49000, category: .top),
        .init(frontImageName: "sample2", name: "벌룬 니트", price: 59000, category: .top),
        .init(frontImageName: "sample3", name: "크롭 점퍼", price: 71000, category: .top),
        .init(frontImageName: "sample1", name: "루즈핏 후드", price: 49000, category: .top),
        .init(frontImageName: "sample2", name: "벌룬 니트", price: 59000, category: .top),
        .init(frontImageName: "sample3", name: "크롭 점퍼", price: 71000, category: .top),
        .init(frontImageName: "sample1", name: "루즈핏 후드", price: 49000, category: .top),
        .init(frontImageName: "sample2", name: "벌룬 니트", price: 59000, category: .top),
        .init(frontImageName: "sample3", name: "크롭 점퍼", price: 71000, category: .top),
        .init(frontImageName: "sample1", name: "루즈핏 후드", price: 49000, category: .top),
        .init(frontImageName: "sample2", name: "벌룬 니트", price: 59000, category: .top),
        .init(frontImageName: "sample3", name: "크롭 점퍼", price: 71000, category: .top),
        .init(frontImageName: "sample4", name: "기모 팬츠", price: 48000, category: .bottom)
    ]

    // MARK: - Constants
    let bannerHeight: CGFloat = 500                  // 배너 뷰의 고정 높이 (픽셀)
    let blurredBannerHeight: CGFloat = 700            // 흐림 배너 높이 (사용처 불명, 아마 애니메이션 용도)
    let holeSize = CGSize(width: 131, height: 413)    // 특정 UI 요소 크기 (로고 위치 계산용으로 보임)

    // MARK: - Computed Properties
    
    // 스크롤 진행도 계산 (0~1 범위로 300 픽셀 스크롤 내에서 비율 계산)
    var scrollProgress: CGFloat {
        min(max(scrollOffset / 300, 0), 1)
    }

    // 스크롤 진행도에 따른 각도 (0~90도)
    var angleForScroll: Angle {
        .degrees(90 * scrollProgress)
    }

    // 스크롤 진행도에 따른 y 오프셋 보정 (최대 -50 이동)
    var offsetYForScroll: CGFloat {
        -50 * scrollProgress
    }

    // 스크롤 진행도에 따라 두 색상 사이 보간된 색상 반환
    var interpolatedColor: Color {
        Color.interpolateHex(from: "#0038FF", to: "#C4D1FF", fraction: scrollProgress)
    }

    // 현재 선택된 카테고리에 해당하는 아이템만 필터링해서 반환
    var filteredItems: [BrandItem] {
        switch selectedCategory {
        case .all: return items
        case .top: return items.filter { $0.category == .top }
        case .bottom: return items.filter { $0.category == .bottom }
        case .accessory: return items.filter { $0.category == .accessory }
        }
    }

    // MARK: - Functions

    /// 스크롤 오프셋 업데이트 함수, 내부 상태 동시 갱신
    /// - Parameter offset: 현재 스크롤 위치
    func updateScrollOffset(_ offset: CGFloat) {
        debugScrollOffset = offset                       // 디버깅용 변수에 현재 값 저장
        scrollOffset = min(offset, 300)                   // 메인 스크롤 오프셋은 300 이하로 제한
        tabBarScrollOffset = offset                        // 탭바용 오프셋 별도로 저장 (현재는 전체 offset 동일)
        categoryTabBarScrollOffset = offset                // 카테고리 탭바용 오프셋도 동일하게 저장 중
    }

    /// 로고 위치 계산 함수 (GeometryProxy를 사용하여 위치 결정)
    /// - Parameter geo: GeometryProxy (뷰의 크기, 위치 정보)
    /// - Returns: CGPoint (로고 위치)
    func logoPosition(geo: GeometryProxy) -> CGPoint {
        let centerX = geo.size.width / 2 - 70            // 뷰 중앙에서 X축 보정 (-70만큼 왼쪽 이동)
        let centerY = geo.size.height / 2 + offsetYForScroll - 30  // 중앙 Y 기준, 스크롤 오프셋에 따른 Y 위치 조정 (-30 고정 보정)
        let rectLeft = centerX - holeSize.width / 2       // 홀 크기 반만큼 왼쪽으로 이동 (홀 좌측 위치)
        let rectBottom = centerY + holeSize.height / 2    // 홀 크기 반만큼 아래로 이동 (홀 하단 위치)
        let logoX = rectLeft                               // 로고 X 위치는 홀 좌측과 동일
        let logoY = rectBottom - holeSize.height * 0.25   // 로고 Y 위치는 홀 하단에서 홀 높이 1/4만큼 위로 올림
        return CGPoint(x: logoX, y: logoY + min(scrollOffset, 100)) // 스크롤 오프셋 최대 100까지 로고 Y 위치 추가 보정
    }
}

struct TabBarOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
