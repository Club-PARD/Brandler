import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        // 비어있는 브랜드 객체로 placeholder 생성
        let dummy = BrandRecommendation(
            id: 0,
            brandName: "",
            brandLogoImageName: "",
            bannerImageName: "",
            genre: nil,
            slogan: nil
        )
        return SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), brand: dummy)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        let dummy = BrandRecommendation(
            id: 0,
            brandName: "",
            brandLogoImageName: "",
            bannerImageName: "",
            genre: nil,
            slogan: nil
        )
        return SimpleEntry(date: Date(), configuration: configuration, brand: dummy)
    }

    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let sharedDefaults = UserDefaults(suiteName: "group.com.taezoo.brandler")
        let email = sharedDefaults?.string(forKey: "userEmail") ?? "default@example.com"
        
        return await BrandWidgetViewModel.generateTimeline(email: email, configuration: configuration)
    }
}

struct ShowBrand: Widget {
    let kind: String = "ShowBrand"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: ConfigurationAppIntent.self,
            provider: Provider()
        ) { entry in
            ShowBrandEntryView(entry: entry)
        }
    }
}
