import WidgetKit
import SwiftUI

/// 위젯 타임라인 데이터 공급자 (AppIntentTimelineProvider 프로토콜 구현)
struct Provider: AppIntentTimelineProvider {
    
    /// 위젯이 로딩 전 보여줄 임시 데이터
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    /// 위젯 갤러리나 스냅샷에서 보여줄 샘플 데이터
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    /// 위젯 타임라인에 보여줄 데이터 리스트 생성
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        // 현재 시간부터 5시간 간격으로 5개 엔트리 생성
        for hourOffset in 0..<5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        // 타임라인 정책: 마지막 엔트리 이후 다시 timeline() 호출 (데이터 갱신)
        return Timeline(entries: entries, policy: .atEnd)
    }
}
