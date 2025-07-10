//import SwiftUI
//import WidgetKit
//import Foundation
//
//// MARK: - Entry 모델
//struct SimpleEntry: TimelineEntry {
//    let date: Date
//    let configuration: ConfigurationAppIntent
//    let brand: BrandRecommendation
//}
//
//// MARK: - Provider
//struct Provider: AppIntentTimelineProvider {
//    func placeholder(in context: Context) -> SimpleEntry {
//        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), brand: .placeholder)
//    }
//
//    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
//        SimpleEntry(date: Date(), configuration: configuration, brand: .placeholder)
//    }
//
//    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
//        // ✅ App Group에서 이메일 불러오기
//        let sharedDefaults = UserDefaults(suiteName: "group.com.taezoo.brandler")
//        let email = sharedDefaults?.string(forKey: "userEmail") ?? "default@example.com"
//
//        return await BrandWidgetViewModel.generateTimeline(
//            configuration: configuration
//        )
//    }
//}
//
//// MARK: - ShowBrandEntryView
//struct ShowBrandEntryView: View {
//    var entry: Provider.Entry
//    @Environment(\.widgetFamily) var family
//
//    var body: some View {
//        contentView
//            .containerBackground(.fill.tertiary, for: .widget)
//    }
//
//    @ViewBuilder
//    var contentView: some View {
//        switch family {
//        case .systemMedium:
//            // 여기에 MediumWidgetView(brand: entry.brand) 가 들어갑니다.
//            // (분리된 뷰이므로 여기서는 제외합니다)
//            EmptyView()
//        default:
//            Text("지원되지 않는 크기입니다.")
//        }
//    }
//}
//
//// MARK: - Widget 본체
//struct ShowBrand: Widget {
//    let kind: String = "ShowBrand"
//
//    var body: some WidgetConfiguration {
//        AppIntentConfiguration(
//            kind: kind,
//            intent: ConfigurationAppIntent.self,
//            provider: Provider()
//        ) { entry in
//            ShowBrandEntryView(entry: entry)
//        }
//    }
//}
//
//// MARK: - Preview + Placeholder
//// ConfigurationAppIntent 확장 추가
//extension ConfigurationAppIntent {
//    static var starEyes: ConfigurationAppIntent {
//        let intent = ConfigurationAppIntent()
//        intent.favoriteEmoji = "🤩"
//        return intent
//    }
//}
//
//// BrandRecommendation 확장 수정
//extension BrandRecommendation {
//    static var placeholder: BrandRecommendation {
//        .init(
//            id: 0,
//            brandName: "플레이스홀더 브랜드",
//            brandLogoImageName: "placeholder_logo",  // 순서 주의
//            bannerImageName: "placeholder_banner",
//            genre: "캐주얼",
//            slogan: "플레이스홀더 문구입니다"
//        )
//    }
//}
