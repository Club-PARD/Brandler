import SwiftUI
import WidgetKit

/// `ShowBrandEntryView`는 위젯의 실제 콘텐츠를 렌더링하는 SwiftUI 뷰입니다.
struct ShowBrandEntryView: View {
    var entry: Provider.Entry

    /// 샘플 브랜드 데이터 (실제로는 타임라인에서 넘겨받아야 합니다)
    var brand = BrandRecommendation.sample

    @Environment(\.widgetFamily) var family

    var body: some View {
        switch family {
        case .systemSmall:
            smallWidgetView
        case .systemMedium:
            mediumWidgetView
        default:
            Text("지원되지 않는 크기입니다.")
        }
    }

    /// 정사각형 위젯 뷰
    var smallWidgetView: some View {
        VStack(spacing: 8) {
            Text("⏰ Time")
                .font(.caption)
                .foregroundColor(.gray)

            Text(entry.date, style: .time)
                .font(.title2)
                .bold()

            Text("💬 Emoji")
                .font(.caption)
                .foregroundColor(.gray)

            Text(entry.configuration.favoriteEmoji)
                .font(.title)
        }
        .padding()
    }

    /// 가로형 위젯 뷰
    var mediumWidgetView: some View {
        ZStack(alignment: .topLeading) {
            Image(brand.bannerImageName)
                .resizable()
                .frame(width: 340, height: 160)
                .clipped()

            VStack(alignment: .leading, spacing: 20) {
                Text("오늘의 디깅 추천 List")
                    .font(.custom("Pretendard-Regular", size: 12))
                    .foregroundColor(.black)
//                    .padding(.top, 12)
//                    .padding(.leading, )
                    .background(
                        // 배경용 둥근 사각형 + 그림자 + 마스크 효과
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(1.0))
                            .frame(width: 109, height: 27)
                            .shadow(color: .black.opacity(0.3), radius: 4, x: 2, y: 2)
                            .overlay(
                                // 블러 처리된 테두리 효과
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.black.opacity(0.3), lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [.black, .clear]),
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                )
                                            )
                                    )
                            )
                    )
                    .overlay(
                        // 위에 얹는 선명한 테두리
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black, lineWidth: 1)
                            .frame(width: 109, height: 27)
                    )
                Spacer()

                Text(brand.brandName)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(Color.black.opacity(0.3))
                    .clipShape(Capsule())
            }
            .padding()
        }
    }
}

#Preview("소형 위젯", as: .systemSmall) {
    ShowBrand() // 등록된 위젯
} timeline: {
    // 프리뷰 타임라인 항목 지정 (2개의 이모지 상태)
    SimpleEntry(date: .now, configuration: .smiley)   // 😀 설정
    SimpleEntry(date: .now, configuration: .starEyes) // 🤩 설정
}

#Preview("중형 위젯", as: .systemMedium) {
    ShowBrand() // 등록된 위젯
} timeline: {
    // 프리뷰 타임라인 항목 지정
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
