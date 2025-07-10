import SwiftUI
import WidgetKit

struct ShowBrandEntryView: View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family

    var body: some View {
        // 브랜드 이름이 없으면 표시하지 않음
        if entry.brand.brandName.isEmpty {
            EmptyView()
        } else {
            contentView
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }

    @ViewBuilder
    var contentView: some View {
        switch family {
        case .systemMedium:
            MediumWidgetView(brand: entry.brand)
        default:
            Text("지원되지 않는 크기입니다.")
        }
    }
}
