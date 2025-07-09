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
        ZStack(alignment: .topLeading) {
            Image(brand.bannerImageName)
                .resizable()
                .frame(width: 160, height: 160)
                .clipped()
            
            LinearGradient(
                gradient: Gradient(colors: [.pageBlue.opacity(0.7), .clear]),
                startPoint: .bottom,
                endPoint: .top
            )
            
            VStack(alignment: .leading, spacing: 20) {
                Text("오늘의 디깅 추천 List")
                    .font(.custom("Pretendard-Regular", size: 11))
                    .foregroundColor(Color.white)
                    .opacity(0.7)
                    .background(
                        // 배경용 둥근 사각형 + 그림자 + 마스크 효과
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.WidgetShadowColor.opacity(0.8))
                            .frame(width:81, height:20)
                            .shadow(color: .black.opacity(0.3), radius: 4, x: 2, y: 2)
                            .overlay(
                                // 블러 처리된 테두리 효과
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
                        // 선명한 외곽 테두리
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black.opacity(0.1), lineWidth: 1)
                            .frame(width:81, height:20)
                    )
                Spacer()
                    Image(brand.brandLogoImageName)
                        .resizable()
                        .frame(width:25, height :25)
                        .clipShape(Circle())
                        
                    Text(brand.brandName)
                        .font(.custom("Pretendard-Medium", size: 20))
                        .foregroundColor(Color.lastTxt)
                        .padding(.top, 10)
            }
            .padding()
        }
    }
    
    /// 가로형 위젯 뷰
    var mediumWidgetView: some View {
        ZStack(alignment: .topLeading) {
            Image(brand.bannerImageName)
                .resizable()
                .frame(width: 340, height: 160)
                .clipped()
            LinearGradient(
                gradient: Gradient(colors: [.pageBlue.opacity(0.7), .clear]),
                startPoint: .leading,
                endPoint: .trailing
            )
            
            VStack(alignment: .leading, spacing: 20) {
                Text("오늘의 디깅 추천 List")
                    .font(.custom("Pretendard-Regular", size: 11))
                    .foregroundColor(Color.white)
                    .opacity(0.7)
                    .background(
                        // 배경용 둥근 사각형 + 그림자 + 마스크 효과
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.WidgetShadowColor.opacity(0.8))
                            .frame(width:109, height:27)
                            .shadow(color: .black.opacity(0.3), radius: 4, x: 2, y: 2)
                            .overlay(
                                // 블러 처리된 테두리 효과
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
                        // 선명한 외곽 테두리
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.black.opacity(0.1), lineWidth: 1)
                            .frame(width:109, height:27)
                    )
                Spacer()
                HStack{
                    Image(brand.brandLogoImageName)
                        .resizable()
                        .frame(width:25, height :25)
                        .clipShape(Circle())
                        
                    Text(brand.brandName)
                        .font(.custom("Pretendard-Medium", size: 20))
                        .foregroundColor(Color.lastTxt)
                }
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color.ProductBackGround) // 배경색
                        .frame(width: 175, height: 35)
                        .opacity(0.5)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.gray, lineWidth: 1) // 테두리
                        .frame(width: 175, height: 35)
                        .opacity(0.5)
                )
                
            }
            .padding()
        }
    }
}

//struct ShowBrandEntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            // 소형 위젯 프리뷰
//            ShowBrandEntryView(entry: SimpleEntry(date: .now, configuration: .smiley))
//                .previewContext(WidgetPreviewContext(family: .systemSmall))
//                .previewDisplayName("소형 위젯")
//
//            // 중형 위젯 프리뷰
//            ShowBrandEntryView(entry: SimpleEntry(date: .now, configuration: .starEyes))
//                .previewContext(WidgetPreviewContext(family: .systemMedium))
//                .previewDisplayName("중형 위젯")
//        }
//    }
//}
