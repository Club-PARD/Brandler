//import SwiftUI
//
//struct DescriptionHeightPreferenceKey: PreferenceKey {
//    static var defaultValue: CGFloat = 0
//    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
//        value = nextValue()
//    }
//}
//
//struct BrandInfoOverlayView: View {
//    let scrollOffset: CGFloat
//    let bannerHeight: CGFloat
//    let brand: Brand
//    let brandId: Int
//    let isScraped: Bool
//
//    var onDescriptionHeightChange: (CGFloat) -> Void = { _ in }
//    var onBrandNameWidthChange: (CGFloat) -> Void = { _ in }
//
//    @State private var showFullText = false
//    @State private var isLiked: Bool
//    @State private var descriptionHeight: CGFloat = 0
//    @State private var brandNameWidth: CGFloat = 0
//
//    @StateObject private var scrapeAPI: ScrapeServerAPI
//    @EnvironmentObject var session: UserSessionManager
//
//    init(
//        scrollOffset: CGFloat,
//        bannerHeight: CGFloat,
//        brand: Brand,
//        brandId: Int,
//        isScraped: Bool,
//        onDescriptionHeightChange: @escaping (CGFloat) -> Void = { _ in },
//        onBrandNameWidthChange: @escaping (CGFloat) -> Void = { _ in }
//    ) {
//        self.scrollOffset = scrollOffset
//        self.bannerHeight = bannerHeight
//        self.brand = brand
//        self.brandId = brandId
//        self.isScraped = isScraped
//        self.onDescriptionHeightChange = onDescriptionHeightChange
//        self.onBrandNameWidthChange = onBrandNameWidthChange
//        _scrapeAPI = StateObject(wrappedValue: ScrapeServerAPI(brand: brand))
//        _isLiked = State(initialValue: isScraped)
//    }
//
//    var descriptionText: String {
//        brand.description
//    }
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            Image(brand.brandLogoUrl)
//                .resizable()
//                .frame(width: 48, height: 48)
//                .clipShape(Circle())
//                .overlay(Circle().stroke(Color.white, lineWidth: 2))
//                .shadow(radius: 4)
//                .padding(.bottom, 7)
//
//            HStack(alignment: .center, spacing: 8) {
//                Text(brand.name)
//                    .font(.custom("Pretendard-Bold", size: 35))
//                    .foregroundColor(.white)
//                    .fixedSize()
//                    .background(
//                        GeometryReader { geo in
//                            Color.clear
//                                .onAppear {
//                                    brandNameWidth = geo.size.width
//                                    onBrandNameWidthChange(brandNameWidth)
//                                }
//                        }
//                    )
//
//                Image("Level\(brand.brandLevel)")
//                    .resizable()
//                    .frame(width: 27, height: 27)
//
//                Spacer(minLength: 273 - brandNameWidth)
//
//                Button(action: {
//                    withAnimation {
//                        isLiked.toggle()
//                        if let email = session.userData?.email, isLiked {
//                            scrapeAPI.patchLike(email: email, brandId: brandId)
//                        }
//                    }
//                }) {
//                    Image(systemName: isLiked ? "heart.fill" : "heart")
//                        .font(.system(size: 24))
//                        .foregroundColor(isLiked ? .blue : .white)
//                }
//            }
//            .padding(.bottom, 5)
//
//            Text(brand.brandGenre)
//                .font(.custom("Pretendard-Medium", size: 10))
//                .foregroundColor(.white)
//                .opacity(0.7)
//                .frame(height: 16)
//                .frame(minWidth: 48)
//                .background(
//                    RoundedRectangle(cornerRadius: 12).fill(Color.BrandGenre)
//                )
//                .overlay(
//                    RoundedRectangle(cornerRadius: 12)
//                        .stroke(Color.BrandFont, lineWidth: 1)
//                )
//
//            HStack(alignment: .top, spacing: 8) {
//                VStack(alignment: .leading, spacing: 0) {
//                    if showFullText {
//                        (
//                            Text(descriptionText)
//                            + Text("   닫기")
//                                .bold()
//                                .font(.custom("Pretendard-Light", size: 12))
//                        )
//                        .font(.system(size: 12))
//                        .foregroundColor(.white)
//                        .onTapGesture {
//                            withAnimation {
//                                showFullText = false
//                            }
//                        }
//                        .background(
//                            GeometryReader { geo in
//                                Color.clear
//                                    .preference(key: DescriptionHeightPreferenceKey.self, value: geo.size.height)
//                            }
//                        )
//                    } else {
//                        (
//                            Text(truncatedText + "... ")
//                            + Text("더보기")
//                                .bold()
//                                .font(.custom("Pretendard-Regular", size: 12))
//                        )
//                        .font(.system(size: 12))
//                        .foregroundColor(.white)
//                        .onTapGesture {
//                            withAnimation {
//                                showFullText = true
//                            }
//                        }
//                        .background(
//                            GeometryReader { geo in
//                                Color.clear
//                                    .preference(key: DescriptionHeightPreferenceKey.self, value: geo.size.height)
//                            }
//                        )
//                    }
//                }
//                .frame(maxWidth: 220, alignment: .leading)
//                .padding(.top, 12)
//
//                Button(action: {
//                    if let url = URL(string: brand.brandHomePageUrl) {
//                        UIApplication.shared.open(url)
//                    }
//                }) {
//                    Image("shop")
//                        .foregroundColor(.white)
//                }
//                .padding(.top, 2)
//                .padding(.leading, 100)
//            }
//        }
//        .padding(.all, 16)
//        .frame(maxWidth: .infinity, alignment: .leading)
//        .onPreferenceChange(DescriptionHeightPreferenceKey.self) { newHeight in
//            if newHeight != descriptionHeight {
//                descriptionHeight = newHeight
//                onDescriptionHeightChange(newHeight)
//            }
//        }
//        // ⭐️ 서버에서 isScraped가 바뀔 때 하트 상태도 자동 동기화
//        .onChange(of: isScraped) { oldValue, newValue in
//            isLiked = newValue
//        }
//    }
//
//    var truncatedText: String {
//        descriptionText.count > 60
//        ? String(descriptionText.prefix(60))
//        : descriptionText
//    }
//}
//
//

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
        brand: Brand,
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
        _scrapeAPI = StateObject(wrappedValue: ScrapeServerAPI(brand: brand))
    }

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
                                    onBrandNameWidthChange(brandNameWidth)
                                }
                        }
                    )

                Image("Level\(brand.brandLevel)")
                    .resizable()
                    .frame(width: 27, height: 27)

                Spacer(minLength: 273 - brandNameWidth)

                Button(action: {
                    withAnimation {
                        isScraped.toggle()
                        if let email = session.userData?.email {
                            scrapeAPI.patchLike(email: email, brandId: brandId, isScraped: isScraped)
                        }
                    }
                }) {
                    Image(systemName: isScraped ? "heart.fill" : "heart")
                        .font(.system(size: 24))
                        .foregroundColor(isScraped ? .blue : .white)
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
