import WidgetKit
import SwiftUI

/// 위젯 자체 설정 구조체
struct BrandShowImage: Widget {
    /// 위젯 고유 식별자
    let kind: String = "BrandShowImage"

    var body: some WidgetConfiguration {
        // AppIntentConfiguration을 사용해 인텐트 기반 위젯 구성
        AppIntentConfiguration(kind: kind,
                               intent: ConfigurationAppIntent.self,
                               provider: Provider()) { entry in
            // 위젯에 표시할 뷰 지정
            BrandShowImageEntryView(entry: entry)
                // 위젯 배경색을 시스템 테리어리 색으로 채움
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}
