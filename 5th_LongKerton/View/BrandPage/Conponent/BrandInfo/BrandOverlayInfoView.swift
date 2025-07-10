import SwiftUI

struct DescriptionHeightPreferenceKey: PreferenceKey {
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
    @Binding var isScraped: Bool // ⭐️ @Binding으로 직접 연결

    var onDescriptionHeightChange: (CGFloat) -> Void = { _ in }
    var onBrandNameWidthChange: (CGFloat) -> Void = { _ in }

    @State private var showFullText = false
    @State private var descriptionHeight: CGFloat = 0
    @State private var brandNameWidth: CGFloat = 0

    @StateObject private var scrapeAPI: ScrapeServerAPI
    @EnvironmentObject var session: UserSessionManager

    init(
        scrollOffset: CGFloat,
        bannerHeight: CGFloat,
        brand: BrandInfo,
        brandId: Int,
        isScraped: Binding<Bool>,
        onDescriptionHeightChange: @escaping (CGFloat) -> Void = { _ in },
        onBrandNameWidthChange: @escaping (CGFloat) -> Void = { _ in }
    ) {
        self.scrollOffset = scrollOffset
        self.bannerHeight = bannerHeight
        self.brand = brand
        self.brandId = brandId
        self._isScraped = isScraped
        self.onDescriptionHeightChange = onDescriptionHeightChange
        self.onBrandNameWidthChange = onBrandNameWidthChange
        _scrapeAPI = StateObject(wrappedValue: ScrapeServerAPI())
    }

    var descriptionText: String {
        brand.description
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(brand.brandLogo)
                .resizable()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 4)
                .padding(.bottom, 7)

            HStack(alignment: .center, spacing: 8) {
                Text(brand.brandName)
                    .font(.custom("Pretendard-Bold", size: 35))
                    .foregroundColor(.white)
                    .fixedSize()
                    .background(
                        GeometryReader { geo in
                            Color.clear
                                .onAppear {
                                    brandNameWidth = geo.size.width
                                    onBrandNameWidthChange(brandNameWidth)
                                }
                        }
                    )

                Image("Level\(2)")
                    .resizable()
                    .frame(width: 27, height: 27)

                Spacer(minLength: 250 - brandNameWidth)

                Button(action: {
                    withAnimation {
                        isScraped.toggle()
                    }
                }) {
                    Image(systemName: isScraped ? "heart.fill" : "heart")
                        .font(.system(size: 24))
                        .foregroundColor(isScraped ? .blue : .white)
                }
                .offset(x: -10)
            }
            .padding(.bottom, 5)

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
                            withAnimation {
                                showFullText = false
                            }
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
                            withAnimation {
                                showFullText = true
                            }
                        }
                        .background(
                            GeometryReader { geo in
                                Color.clear
                                    .preference(key: DescriptionHeightPreferenceKey.self, value: geo.size.height)
                            }
                        )
                    }
                }
                .frame(maxWidth: 255, alignment: .leading)
                .padding(.top, 12)

                Button(action: {
                    if let url = URL(string: brand.brandPageUrl) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Image("shop")
                        .foregroundColor(.white)
                }
                .padding(.top, 2)
                .padding(.leading, 100)
            }
        }
        .padding(.all, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .onPreferenceChange(DescriptionHeightPreferenceKey.self) { newHeight in
            if newHeight != descriptionHeight {
                descriptionHeight = newHeight
                onDescriptionHeightChange(newHeight)
            }
        }
    }

    var truncatedText: String {
        descriptionText.count > 60
        ? String(descriptionText.prefix(60))
        : descriptionText
    }
}
