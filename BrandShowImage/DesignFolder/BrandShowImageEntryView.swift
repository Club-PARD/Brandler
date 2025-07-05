import SwiftUI
import WidgetKit

/// 위젯 UI 뷰 - 타임라인 엔트리를 받아 UI 표시
struct BrandShowImageEntryView: View {
    /// 표시할 타임라인 엔트리
    var entry: SimpleEntry

    var body: some View {
        VStack(spacing: 8) {
            Text("Time:")
                .font(.headline)
            
            // 날짜/시간을 시스템 스타일로 표시
            Text(entry.date, style: .time)
                .font(.title2)
            
            Text("Favorite Emoji:")
                .font(.headline)
            
            // 사용자가 설정한 이모지를 텍스트로 표시
            Text(entry.configuration.favoriteEmoji)
                .font(.largeTitle)
        }
        .padding()
    }
}
