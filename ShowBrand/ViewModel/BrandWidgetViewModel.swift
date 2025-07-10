import Foundation
import WidgetKit

enum BrandWidgetViewModel {
    static func generateTimeline(
        email: String,
        configuration: ConfigurationAppIntent
    ) async -> Timeline<SimpleEntry> {
        do {
            // 1. 서버에서 브랜드 리스트 받아오기
            let brands = try await WidgetAPI.fetchBrandRecommendations(for: email)

            // ✅ 디버깅 로그
            print("✅ 서버에서 받아온 브랜드 리스트:")
            for brand in brands {
                print(" - id: \(brand.id), name: \(brand.brandName), banner: \(brand.bannerImageName)")
            }

            // 2. 빈 배열일 경우 아무것도 표시하지 않음
            guard !brands.isEmpty else {
                print("⚠️ 브랜드 리스트가 비어 있음. 타임라인 생략.")
                return Timeline(entries: [], policy: .atEnd)
            }

            // 3. 타임라인 엔트리 생성 (10초 간격)
            let currentDate = Date()
            let entries: [SimpleEntry] = brands.enumerated().map { index, brand in
                let entryDate = Calendar.current.date(byAdding: .second, value: index * 10, to: currentDate)!
                return SimpleEntry(date: entryDate, configuration: configuration, brand: brand)
            }

            return Timeline(entries: entries, policy: .atEnd)

        } catch {
            print("❌ 브랜드 가져오기 실패: \(error)")
            return Timeline(entries: [], policy: .atEnd)
        }
    }
}
