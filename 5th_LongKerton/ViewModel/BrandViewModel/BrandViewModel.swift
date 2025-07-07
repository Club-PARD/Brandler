import SwiftUI
import Foundation

// MARK: - 카테고리 정의
enum Category: String, CaseIterable, Identifiable {
    case all = "전체"
    case top = "상의"
    case bottom = "하의"
    case accessory = "악세사리"

    var id: String { rawValue }
}

// MARK: - ViewModel
final class BrandViewModel: ObservableObject {

    // MARK: - 브랜드 관련 상태
    @Published var brands: [Brand] = Brand.sampleData                            // 디깅된 브랜드 전체
    @Published var filteredBrands: [Brand] = []                    // 선택 장르 기반 필터링 결과
    @Published var selectedGenre: String = "전체"                  // 현재 선택된 장르

    // MARK: - 카테고리 관련
    @Published var selectedCategory: Category = .all
    @Published var items: [Product] = Product.brandItems// 현재 선택된 카테고리 (상품 필터용)

    // MARK: - 스크롤 상태
    @Published var scrollOffset: CGFloat = 0
    @Published var debugScrollOffset: CGFloat = 0
    @Published var tabBarScrollOffset: CGFloat = 0
    @Published var categoryTabBarScrollOffset: CGFloat = 0
    
//    @Published var items: [Product] = [                    // 브랜드 아이템 리스트 (샘플 데이터)
//        .init(productImageUrl: "level1 1", name: "루즈핏 후드", price: 49000, productCategory:  .top),
//        .init(productImageUrl: "level1 1", name: "벌룬 니트", price: 59000, productCategory: .top),
//        .init(productImageUrl: "level1 1", name: "크롭 점퍼", price: 71000, productCategory: .top),
//        .init(productImageUrl: "level1 1", name: "루즈핏 후드", price: 49000, productCategory: .top),
//        .init(productImageUrl: "level1 1", name: "벌룬 니트", price: 59000, productCategory: .top),
//        .init(productImageUrl: "level1 1", name: "크롭 점퍼", price: 71000, productCategory: .top),
//        .init(productImageUrl: "level1 1", name: "루즈핏 후드", price: 49000, productCategory: .top),
//        .init(productImageUrl: "level1 1", name: "벌룬 니트", price: 59000, productCategory: .top),
//        .init(productImageUrl: "level1 1", name: "크롭 점퍼", price: 71000, productCategory: .top),
//        .init(productImageUrl: "level1 1", name: "루즈핏 후드", price: 49000, productCategory: .top),
//        .init(productImageUrl: "level1 1", name: "벌룬 니트", price: 59000, productCategory: .top),
//        .init(productImageUrl: "level1 1", name: "크롭 점퍼", price: 71000, productCategory: .top),
//        .init(productImageUrl: "level1 1", name: "기모 팬츠", price: 48000, productCategory: .top)
//    ]
//
    // MARK: - 필터링된 상품 리스트 (selectedCategory 기준)
    var filteredItems: [Product] {
        if selectedCategory == .all {
            return items
        } else {
            return items.filter { $0.productCategory.rawValue == selectedCategory.rawValue }
        }
    }

    // MARK: - 배너, 구멍 크기 등 UI 관련 상수
    let bannerHeight: CGFloat = 500
    let blurredBannerHeight: CGFloat = 700
    let holeSize = CGSize(width: 131, height: 413)

    // MARK: - 스크롤 진행도에 따른 값 계산
    var scrollProgress: CGFloat {
        min(max(scrollOffset / 300, 0), 1)
    }

    var angleForScroll: Angle {
        .degrees(90 * scrollProgress)
    }

    var offsetYForScroll: CGFloat {
        -50 * scrollProgress
    }

    var interpolatedColor: Color {
        Color.interpolateHex(from: Color.Inter, to: Color.LogBlue, fraction: scrollProgress)
    }

    // MARK: - 스크롤 오프셋 업데이트
    func updateScrollOffset(_ offset: CGFloat) {
        debugScrollOffset = offset
        scrollOffset = min(offset, 300)
        tabBarScrollOffset = offset
        categoryTabBarScrollOffset = offset
    }

    // MARK: - 로고 위치 계산 (GeometryProxy 기반)
    func logoPosition(geo: GeometryProxy) -> CGPoint {
        let centerX = geo.size.width / 2 - 70
        let centerY = geo.size.height / 2 + offsetYForScroll - 30
        let rectLeft = centerX - holeSize.width / 2
        let rectBottom = centerY + holeSize.height / 2
        let logoX = rectLeft
        let logoY = rectBottom - holeSize.height * 0.25
        return CGPoint(x: logoX, y: logoY + min(scrollOffset, 100))
    }

    // MARK: - 브랜드 필터링 및 삭제
    func filterBrands() {
        if selectedGenre == "전체" {
            filteredBrands = brands
        } else {
            filteredBrands = brands.filter { $0.brandGenre == selectedGenre }
        }
    }

    func deleteBrand(_ brand: Brand) {
        brands.removeAll { $0.id == brand.id }
        filterBrands()
    }

    var hasNoScrapedBrands: Bool {
        brands.isEmpty
    }

    // MARK: - 고래 레벨 및 진행도 계산
    var diggingCount: Int {
        brands.count
    }

    var diggingDistanceInKM: Double {
        Double(diggingCount) * 0.1
    }

    var remainingDistance: Double {
        max(0, 10.0 - diggingDistanceInKM)
    }

    var whaleLevel: Int {
        switch diggingDistanceInKM {
        case 0..<2.0: return 0
        case 2.0..<4.0: return 1
        case 4.0..<6.0: return 2
        case 6.0..<8.0: return 3
        case 8.0..<10.0: return 4
        default: return 5
        }
    }

    var whaleImageName: String {
        "level\(whaleLevel)"
    }

    func progress(for step: Int) -> Double {
        let lower = Double((step - 1) * 2)
        let upper = Double(step * 2)
        let distance = diggingDistanceInKM

        if distance >= upper {
            return 1.0
        } else if distance <= lower {
            return 0.0
        } else {
            return (distance - lower) / 2.0
        }
    }
}

// MARK: - 탭바 위치 전달용 PreferenceKey
struct TabBarOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
