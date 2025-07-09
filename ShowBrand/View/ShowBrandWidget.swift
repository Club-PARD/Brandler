import WidgetKit
import SwiftUI

/// 메인 위젯 정의입니다. 시스템에 위젯을 등록하고, UI 구성 방식을 지정합니다.
struct ShowBrand: Widget {
    let kind: String = "ShowBrand" // 위젯 식별자

    var body: some WidgetConfiguration {
        // AppIntent 기반 구성을 정의
        AppIntentConfiguration(
            kind: kind,
            intent: ConfigurationAppIntent.self, // 사용자 설정 intent
            provider: Provider() // 타임라인 제공자
        ) { entry in
            ShowBrandEntryView(entry: entry) // 위젯 본문 뷰
                .containerBackground(.fill.tertiary, for: .widget) // 위젯 배경 스타일
        }
    }
}
