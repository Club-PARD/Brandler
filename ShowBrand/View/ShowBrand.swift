import SwiftUI
import WidgetKit
import Foundation

// MARK: - AppIntent 프리뷰 확장
/// ConfigurationAppIntent를 위한 프리셋 값을 정의하는 확장입니다.
/// 프리뷰용으로 이모지 값을 설정해 보여줍니다.
extension ConfigurationAppIntent {
    static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }

    static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

// MARK: - 단일 Entry 모델
/// 타임라인에서 사용할 단일 entry입니다.
/// date는 위젯의 갱신 시점을 나타내며,
/// configuration은 사용자의 intent 설정을 포함합니다.
struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

// MARK: - 타임라인 Provider
/// 위젯의 데이터 공급자 역할을 합니다.
struct Provider: AppIntentTimelineProvider {

    /// 위젯이 로드되기 전에 보여줄 플레이스홀더 (정적 컨텐츠용)
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    /// 위젯이 빠르게 렌더링되어야 할 때 사용할 스냅샷 (프리뷰용)
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }

    /// 실제 타임라인 데이터 제공 함수
    /// 여기서는 매 분마다 데이터를 새로 생성해 60개의 entry를 생성
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let currentDate = Date()
        let entries = (0..<60).map { offset in
            SimpleEntry(
                date: Calendar.current.date(byAdding: .minute, value: offset, to: currentDate)!,
                configuration: configuration
            )
        }
        return Timeline(entries: entries, policy: .atEnd)
    }
}

// MARK: - Entry View
/// 위젯에 표시될 실제 View
struct ShowBrandEntryView: View {
    var entry: Provider.Entry
    
    /// 현재 위젯의 크기를 가져오기 위한 환경 변수
    @Environment(\.widgetFamily) var family

    /// 디버깅 및 샘플용 BrandRecommendation 선택
    /// 위젯 크기에 따라 다른 브랜드를 표시
    var brand: BrandRecommendation {
        switch family {
        case .systemMedium:
            return BrandRecommendation.sampleData[1] // 미디엄 위젯: 2번째 브랜드
        default:
            return BrandRecommendation.sampleData[0] // 기본: 첫 번째
        }
    }

    /// 실제 body 뷰 정의
    var body: some View {
        contentView
            .containerBackground(.fill.tertiary, for: .widget) // 배경 처리
    }

    /// 위젯 크기에 따라 다른 뷰를 선택
    @ViewBuilder
    var contentView: some View {
        switch family {
        case .systemMedium:
            mediumWidgetView
        default:
            Text("지원되지 않는 크기입니다.")
        }
    }
    /// 미디엄 위젯용 뷰 (배너 이미지 + 브랜드 정보)
    var mediumWidgetView: some View {
        ZStack(alignment: .topLeading) {
            // 배경 배너 이미지
            Image(brand.bannerImageName)
                .resizable()
                .frame(width: 340, height: 160)
                .clipped()

            // 좌에서 우로 흐르는 블루 그라디언트
            LinearGradient(
                gradient: Gradient(colors: [.pageBlue.opacity(0.7), .clear]),
                startPoint: .leading,
                endPoint: .trailing
            )

            // 텍스트 및 브랜드 정보
            VStack(alignment: .leading, spacing: 20) {
                // 제목 텍스트 (그라디언트 배경 + 외곽선)
                Text("오늘의 디깅 추천 List")
                    .font(.custom("Pretendard-Regular", size: 11))
                    .foregroundColor(.white)
                    .opacity(0.7)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.WidgetShadowColor.opacity(0.8))
                            .frame(width:109, height:27)
                            .shadow(color: .black.opacity(0.3), radius: 4, x: 2, y: 2)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.black.opacity(0.7), lineWidth: 4)
                                    .blur(radius: 2)
                                    .offset(x: 2, y: 2)
                                    .mask(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [.black, .clear]),
                                                    startPoint: .top,
                                                    endPoint: .bottom
                                                )
                                            )
                                    )
                            )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black.opacity(0.1), lineWidth: 1)
                            .frame(width:109, height:27)
                    )

                Spacer()

                // 브랜드 로고 + 이름
                HStack {
                    Image(brand.brandLogoImageName)
                        .resizable()
                        .frame(width: 25, height: 25)
                        .clipShape(Circle())

                    Text(brand.brandName)
                        .font(.custom("Pretendard-Medium", size: 20))
                        .foregroundColor(Color.lastTxt)
                }
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color.ProductBackGround)
                        .frame(width: 175, height: 35)
                        .opacity(0.5)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.gray, lineWidth: 1)
                        .frame(width: 175, height: 35)
                        .opacity(0.5)
                )
            }
            .padding()
        }
    }
}

// MARK: - 위젯 본체 정의
struct ShowBrand: Widget {
    let kind: String = "ShowBrand"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: ConfigurationAppIntent.self,
            provider: Provider()
        ) { entry in
            ShowBrandEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

// MARK: - 프리뷰 (Xcode에서 미리보기용)
struct ShowBrandEntryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // 중형 위젯 프리뷰
            ShowBrandEntryView(entry: SimpleEntry(date: .now, configuration: .starEyes))
                .containerBackground(.fill.tertiary, for: .widget)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .previewDisplayName("중형 위젯")
        }
    }
}
