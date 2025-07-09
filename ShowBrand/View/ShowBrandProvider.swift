import WidgetKit

/// `Provider`는 `AppIntentTimelineProvider`를 채택하여
/// 위젯의 타임라인 데이터를 제공하는 역할을 합니다.
struct Provider: AppIntentTimelineProvider {

    /// 위젯이 로딩되기 전에 표시할 placeholder 데이터를 제공합니다.
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    /// 위젯 갤러리에서 미리보기를 렌더링할 때 사용할 snapshot을 반환합니다.
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }

    /// 실제 위젯에서 사용할 타임라인 데이터를 생성합니다.
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let currentDate = Date()

        // 1분 간격으로 60개의 타임라인 항목 생성 (1시간 분량)
        let entries = (0..<60).map { minuteOffset -> SimpleEntry in
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
            return SimpleEntry(date: entryDate, configuration: configuration)
        }

        // 타임라인에 항목들을 제공하고, 마지막 항목 이후에 업데이트함
        return Timeline(entries: entries, policy: .atEnd)
    }
}
