import SwiftUI

struct DescriptionHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct TitleHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct BrandInfoOverlayView: View {
    let scrollOffset: CGFloat
    let bannerHeight: CGFloat
    let brand: BrandInfo
    let brandId: Int
    @Binding var isScraped: Bool

    var onDescriptionHeightChange: (CGFloat) -> Void = { _ in }
    var onTitleHeightChange: (CGFloat) -> Void = { _ in } //

    @State private var showFullText = false
    @State private var descriptionHeight: CGFloat = 0
    @EnvironmentObject var session: UserSessionManager
    @StateObject private var scrapeAPI: ScrapeServerAPI

    init(
        scrollOffset: CGFloat,
        bannerHeight: CGFloat,
        brand: BrandInfo,
        brandId: Int,
        isScraped: Binding<Bool>,
        onDescriptionHeightChange: @escaping (CGFloat) -> Void = { _ in },
        onTitleHeightChange: @escaping (CGFloat) -> Void = { _ in }
    ) {
        self.scrollOffset = scrollOffset
        self.bannerHeight = bannerHeight
        self.brand = brand
        self.brandId = brandId
        self._isScraped = isScraped
        self.onDescriptionHeightChange = onDescriptionHeightChange
        self.onTitleHeightChange = onTitleHeightChange
        _scrapeAPI = StateObject(wrappedValue: ScrapeServerAPI())
    }

    var descriptionText: String { brand.description }

    var truncatedText: String {
        descriptionText.count > 60
        ? String(descriptionText.prefix(60))
        : descriptionText
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(brand.brandLogo)
                .resizable()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 4)
                .padding(.bottom, 7)

            HStack(alignment: .top, spacing: 8) {
                // ✅ 수정된 부분 시작
                HStack(alignment: .firstTextBaseline, spacing: 12) {
                    Text(brand.brandName)
                        .font(.custom("Pretendard-Bold", size: 35))
                        .foregroundColor(.white)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)

                    Image(brand.levelImageName) // ✅ 동적으로 레벨 이미지 불러오기
                         .resizable()
                         .frame(width: 27, height: 27)
                         .offset(y: 3)
                         .alignmentGuide(.firstTextBaseline) { d in d[.bottom] }
                }
                .frame(width: 255, alignment: .leading)
                .padding(.leading, 12)
                .overlay(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                let height = geo.size.height
                                onTitleHeightChange(height)
                            }
                            .onChange(of: geo.size.height) { oldHeight, newHeight in
                                onTitleHeightChange(newHeight)
                            }
                    }
                )
                Button(action: {
                    withAnimation { isScraped.toggle() }
                }) {
                    Image(systemName: isScraped ? "heart.fill" : "heart")
                        .font(.system(size: 24))
                        .foregroundColor(isScraped ? .blue : .white)
                        .opacity(0.65)
                }
                .offset(y: 10)
                .padding(.leading, 65)

            }
            .padding(.bottom, 4)
            .offset(x: -10)

            Text(brand.genre)
                .font(.custom("Pretendard-Medium", size: 10))
                .foregroundColor(.white)
                .opacity(0.7)
                .frame(height: 16)
                .frame(minWidth: 48)
                .background(
                    RoundedRectangle(cornerRadius: 12).fill(Color.BrandGenre)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.BrandFont, lineWidth: 1)
                )

            HStack(alignment: .top, spacing: 8) {
                VStack(alignment: .leading, spacing: 0) {
                    if showFullText {
                        (
                            Text(descriptionText)
                            + Text("   닫기")
                                .bold()
                                .font(.custom("Pretendard-Light", size: 12))
                        )
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .onTapGesture {
                            withAnimation { showFullText = false }
                        }
                        .background(
                            GeometryReader { geo in
                                Color.clear
                                    .preference(key: DescriptionHeightPreferenceKey.self, value: geo.size.height)
                            }
                        )
                    } else {
                        (
                            Text(truncatedText + "... ")
                            + Text("더보기")
                                .bold()
                                .font(.custom("Pretendard-Regular", size: 12))
                        )
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .onTapGesture {
                            withAnimation { showFullText = true }
                        }
                        .background(
                            GeometryReader { geo in
                                Color.clear
                                    .preference(key: DescriptionHeightPreferenceKey.self, value: geo.size.height)
                            }
                        )
                    }
                }
                .frame(width: 255, alignment: .leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 12)

                Button(action: {
                    if let url = URL(string: brand.brandPageUrl) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Image("shop")
                        .foregroundColor(.white)
                        .opacity(0.65)
                }
                .padding(.top, 2)
                .padding(.leading, 70)
            }
        }
        .padding(.all, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            GeometryReader { geo in
                Color.clear
                    .preference(key: DescriptionHeightPreferenceKey.self, value: geo.size.height)
            }
        )
        .onPreferenceChange(DescriptionHeightPreferenceKey.self) { newHeight in
            if newHeight != descriptionHeight {
               
                descriptionHeight = newHeight
                onDescriptionHeightChange(newHeight)
            }
        }
        .onPreferenceChange(TitleHeightPreferenceKey.self) { newTitleHeight in
          
            onTitleHeightChange(newTitleHeight)
        }
    }
}
