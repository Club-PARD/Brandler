import WidgetKit
import SwiftUI

// MARK: - 위젯에 전달될 데이터 구조
struct SimpleEntry: TimelineEntry {
    let date: Date
}

// MARK: - 데이터 제공자
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 5, to: currentDate)!
        let entry = SimpleEntry(date: currentDate)
        let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
        completion(timeline)
    }
}

// MARK: - 위젯 UI 뷰
struct MyWidgetEntryView: View {
    var entry: SimpleEntry

    var body: some View {
        ZStack {
            Color(.systemBackground)
            VStack {
                Text("🕒 지금 시간")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(entry.date, style: .time)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.blue)
            }
            .padding()
        }
    }
}

// MARK: - 위젯 정의
struct MyWidgetExtension: Widget {
    let kind: String = "MyWidgetExtension"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("시계 위젯")
        .description("현재 시간을 보여주는 간단한 위젯입니다.")
        .supportedFamilies([.systemSmall])
    }
}

// MARK: - 프리뷰 (기존 방식 + 최신 방식 병행)

/// 최신 방식 (Xcode 15 이상)
#Preview("위젯 전체 미리보기", as: .systemSmall) {
    MyWidgetExtension()
} timeline: {
    SimpleEntry(date: .now)
}
