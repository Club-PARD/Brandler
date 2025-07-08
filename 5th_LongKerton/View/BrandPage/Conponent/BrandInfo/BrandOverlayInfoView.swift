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
    let brand: Brand

    var onDescriptionHeightChange: (CGFloat) -> Void = { _ in }
    var onBrandNameWidthChange: (CGFloat) -> Void = { _ in }  // ✅ 추가

    @State private var showFullText = false
    @State private var isLiked = false
    @State private var descriptionHeight: CGFloat = 0
    @State private var brandNameWidth: CGFloat = 0

    var descriptionText: String {
        brand.description
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(brand.brandLogoUrl)
                .resizable()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 4)
                .padding(.bottom, 7)

            HStack(alignment: .center, spacing: 8) {
                Text(brand.name)
                    .font(.custom("Pretendard-Bold", size: 35))
                    .foregroundColor(.white)
                    .fixedSize()
                    .background(
                        GeometryReader { geo in
                            Color.clear
                                .onAppear {
                                    brandNameWidth = geo.size.width
                                    onBrandNameWidthChange(brandNameWidth) // ✅ 전달
                                }
                        }
                    )

                Image("Level\(brand.brandLevel)")
                    .resizable()
                    .frame(width: 27, height: 27)

                Spacer(minLength: 250 - brandNameWidth)

                Button(action: {
                    withAnimation { isLiked.toggle() }
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .font(.system(size: 24))
                        .foregroundColor(isLiked ? .blue : .white)
                }
            }
            .padding(.bottom, 5)

            Text(brand.brandGenre)
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
                .frame(maxWidth: 220, alignment: .leading)
                .padding(.top, 12)

                Button(action: {
                    if let url = URL(string: brand.brandHomePageUrl) {
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

#Preview {
    let mockBrand = Brand(
        id: UUID(),
        name: "샘플 브랜드",
        brandGenre: "스트릿",
        description: "이 브랜드는 세련된 디자인과 감각적인 제품으로 유명합니다. 개성 있고 유니크한 브랜드 스토리를 가지고 있으며, 많은 셀럽들이 착용한 이력이 있습니다.",
        brandBannerUrl: "brandBanner",
        brandLogoUrl: "brandLogo",
        brandHomePageUrl: "https://www.example.com",
        brandLevel: 1
    )
    
    ZStack {
        Color.black
        BrandInfoOverlayView(
            scrollOffset: 0,
            bannerHeight: 300,
            brand: mockBrand,
            onDescriptionHeightChange: { height in
                print("설명 텍스트 높이: \(height)")
            }
        )
    }
    .frame(height: 250)
}
