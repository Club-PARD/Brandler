import SwiftUI
import WidgetKit

/// 위젯 프리뷰 설정
#Preview(as: .systemSmall) {
    // 실제 위젯 인스턴스
    BrandShowImage()
} timeline: {
    // 프리뷰 타임라인에 보여줄 샘플 엔트리들
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
