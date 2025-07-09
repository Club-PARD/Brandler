
import SwiftUI
import Foundation

enum Category: String, CaseIterable, Identifiable {
    case all = "전체"
    case top = "상의"
    case bottom = "하의"
    case accessory = "악세사리"
    var id: String { rawValue }
}

@MainActor
final class BrandViewModel: ObservableObject {
    @Published var brands: [Brand] = Brand.sampleData
    @Published var filteredBrands: [Brand] = []
    @Published var selectedGenre: String = "전체"
    @Published var selectedCategory: Category = .all
    @Published var items: [Product] = Product.brandItems
    @Published var scrollOffset: CGFloat = 0
    @Published var debugScrollOffset: CGFloat = 0
    @Published var tabBarScrollOffset: CGFloat = 0
    @Published var categoryTabBarScrollOffset: CGFloat = 0
    @Published var brandNameWidth: CGFloat = 0

    var filteredItems: [Product] {
        selectedCategory == .all ? items : items.filter { $0.productCategory.rawValue == selectedCategory.rawValue }
    }

    let bannerHeight: CGFloat = 500
    let blurredBannerHeight: CGFloat = 700
    let holeSize = CGSize(width: 131, height: 413)

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

    func updateScrollOffset(_ offset: CGFloat) {
        debugScrollOffset = offset
        scrollOffset = min(offset, 300)
        tabBarScrollOffset = offset
        categoryTabBarScrollOffset = offset
    }

    func logoPosition(geo: GeometryProxy) -> CGPoint {
        let centerX = geo.size.width / 2 - 70
        let centerY = geo.size.height / 2 + offsetYForScroll - 30
        let rectLeft = centerX - holeSize.width / 2
        let rectBottom = centerY + holeSize.height / 2
        let logoX = rectLeft
        let logoY = rectBottom - holeSize.height * 0.25
        return CGPoint(x: logoX, y: logoY + min(scrollOffset, 100))
    }

    func filterBrands() {
        filteredBrands = selectedGenre == "전체" ? brands : brands.filter { $0.brandGenre == selectedGenre }
    }

    func deleteBrand(_ brand: Brand) {
        brands.removeAll { $0.id == brand.id }
        filterBrands()
    }

    var hasNoScrapedBrands: Bool {
        brands.filter { $0.isScraped }.isEmpty
    }

    var diggingCount: Int {
        brands.filter { $0.isScraped }.count
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

    // 서버에서 스크랩 브랜드 GET 후 Brand에 매핑
    func fetchScrapedBrandsFromServer(email: String) async {
        let api = ScrapeServerAPI()
        do {
            let scrapedBrandCards = try await api.fetchScrapedBrands(email: email)
            var updatedBrands = Brand.sampleData.map { brand in
                var mutableBrand = brand
                mutableBrand.isScraped = false
                return mutableBrand
            }
            for card in scrapedBrandCards {
                if let index = updatedBrands.firstIndex(where: { $0.id == card.brandId }) {
                    updatedBrands[index].isScraped = true
                }
            }
            self.brands = updatedBrands
            self.filterBrands()
        } catch {
            print("Failed to fetch scraped brands: \(error)")
        }
    }

    /// 브랜드 스크랩 해제(삭제) & 서버 동기화 & 최신화
    func unsrapeAndSync(brand: Brand, email: String) async {
        if let idx = brands.firstIndex(where: { $0.id == brand.id }) {
            brands[idx].isScraped = false
        }
        let api = ScrapeServerAPI()
        await withCheckedContinuation { continuation in
            api.patchLike(email: email, brandId: brand.id, isScraped: false) {
                continuation.resume()
            }
        }
        await fetchScrapedBrandsFromServer(email: email)
    }
}

struct TabBarOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
