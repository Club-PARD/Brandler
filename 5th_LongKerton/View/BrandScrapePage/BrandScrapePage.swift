//import SwiftUI
//
//struct BrandScrapePage: View {
//    @State private var showSecondModal = false
//    @State private var offsetY: CGFloat = 0
//    @GestureState private var dragOffset: CGFloat = 0
//    @StateObject private var viewModel = BrandViewModel()
//
//    @StateObject private var scrapeAPI = ScrapeServerAPI()
//    @State private var scrapedBrandList: [BrandCard] = []
//    @State private var flippedID: Int? = nil
//    @State private var currentPage: Int = 0
//
//    @State private var selectedBrand: BrandCard? = nil
//    @State private var showBrandPage: Bool = false
//
//    private let itemsPerPage = 9
//
//    // 3x3 그리드 포맷을 유지한 페이지 분할
//    var pagedBrands: [[BrandCard?]] {
//        stride(from: 0, to: scrapedBrandList.count, by: itemsPerPage).map { start in
//            var slice = Array(scrapedBrandList[start..<min(start + itemsPerPage, scrapedBrandList.count)]).map { Optional($0) }
//            while slice.count < itemsPerPage {
//                slice.append(nil)
//            }
//            return slice
//        }
//    }
//
//    var body: some View {
//        NavigationStack {
//            ZStack(alignment: .topTrailing) {
//                Color.black.opacity(0.8).edgesIgnoringSafeArea(.all)
//                Image("whaleBackground")
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea()
//                    .opacity(0.8)
//                    .offset(x: 13)
//
//                LinearGradient(
//                    gradient: Gradient(colors: [
//                        Color.BackgroundBlue.opacity(0.8),
//                        Color.black.opacity(0.8)
//                    ]),
//                    startPoint: .top,
//                    endPoint: .bottom
//                ).ignoresSafeArea()
//
//                VStack {
//                    Text("My 디깅함")
//                        .font(.custom("Pretendard-Bold", size: 15))
//                        .foregroundColor(.white)
//                        .padding(.top, 20)
//
//                    Spacer().frame(height: 63)
//
//                    Button(action: {
//                        showSecondModal = true
//                    }) {
//                        Text("단계 레벨 가이드 보기")
//                            .font(.custom("Pretendard-Light", size: 10))
//                            .foregroundColor(.gray)
//                            .underline()
//                    }
//                    .padding(.bottom, 10)
//                    .padding(.leading, 230)
//
//                    VStack {
//                        if scrapedBrandList.isEmpty {
//                            ZStack {
//                                Color.clear
//                                Text("아직 스크랩한 브랜드가 없어요.")
//                                    .font(.custom("Pretendard-Regular", size: 12))
//                                    .foregroundColor(.white.opacity(0.8))
//                                    .multilineTextAlignment(.center)
//                            }
//                            .frame(height: 440)
//                        } else {
//                            TabView(selection: $currentPage) {
//                                ForEach(0..<pagedBrands.count, id: \.self) { pageIndex in
//                                    let brands = pagedBrands[pageIndex]
//                                    VStack {
//                                        ForEach(0..<3, id: \.self) { row in
//                                            HStack(spacing: 11) {
//                                                ForEach(0..<3, id: \.self) { col in
//                                                    let index = row * 3 + col
//                                                    if let brand = brands[index] {
//                                                        // BrandCardVIew로 카드 표시
//                                                        BrandFlipCardView(
//                                                            brand: brand,
//                                                            flippedID: $flippedID,
//                                                            onDelete: {
//                                                                Task {
//                                                                        let email = UserSessionManager.shared.emailString ?? ""
//                                                                        let updatedList = await viewModel.unsrapeAndRefresh(email: email, brand: brand)
//                                                                        scrapedBrandList = updatedList // UI 갱신
//                                                                    }
//                                                            },
//                                                            onShop: {
//                                                                selectedBrand = brand
//                                                                showBrandPage = true
//                                                            }
//                                                        )
//                                                    } else {
//                                                        Color.clear
//                                                    }
//                                                }
//                                                .frame(width: 99, height: 124)
//                                            }
//                                            if row < 2 {
//                                                Rectangle()
//                                                    .fill(Color.white.opacity(0.3))
//                                                    .frame(height: 1)
//                                                    .frame(width: 360)
//                                                    .padding(.top, 17)
//                                                    .padding(.bottom, 17)
//                                            }
//                                        }
//                                    }
//                                    .padding(.vertical, 30)
//                                    .padding(.top, 30)
//                                    .tag(pageIndex)
//                                }
//                                .padding(.top, 0)
//                            }
//                            .tabViewStyle(.page(indexDisplayMode: .never))
//                            HStack(spacing: 8) {
//                                ForEach(0..<pagedBrands.count, id: \.self) { index in
//                                    Circle()
//                                        .fill(index == currentPage ? Color.ScrollPoint : Color.nickBox)
//                                        .frame(width: 8, height: 8)
//                                }
//                            }
//                        }
//                    }
//                    .padding(.bottom, 50)
//                    .background(
//                        RoundedRectangle(cornerRadius: 12)
//                            .fill(Color.clear)
//                            .overlay(
//                                ZStack {
//                                    LinearGradient(
//                                        gradient: Gradient(colors: [
//                                            Color.Gradient1.opacity(0.5),
//                                            Color.Gradient2.opacity(0.5),
//                                            Color.Gradient3.opacity(0.5),
//                                            Color.Gradient4.opacity(0.5),
//                                            Color.Gradient5.opacity(0.5)
//                                        ]),
//                                        startPoint: .top,
//                                        endPoint: .bottom
//                                    )
//                                    .opacity(0.5)
//                                    .blur(radius: 0.3)
//
//                                    Color.white.opacity(0.24)
//                                }
//                                .clipShape(RoundedRectangle(cornerRadius: 12))
//                            )
//                    )
//                    .overlay(
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 12)
//                                .stroke(Color.white.opacity(0.2), lineWidth: 2)
//                            RoundedRectangle(cornerRadius: 12)
//                                .stroke(Color.white.opacity(0.4), lineWidth: 0.8)
//                        }
//                    )
//                    .shadow(color: Color.black.opacity(0.1), radius: 8, y: 2)
//                    .opacity(0.9)
//                    .frame(maxWidth: .infinity)
//                    .padding(.horizontal, 40)
//                    .padding(.bottom, 50)
//
//                    Spacer()
//                }
//
//                if showSecondModal {
//                    SecondModalView(isVisible: $showSecondModal)
//                }
//            }
//            .onAppear {
//                offsetY = UIScreen.main.bounds.height - 100
//                Task {
//                    let userEmail = UserSessionManager.shared.emailString ?? ""
//                    do {
//                        scrapedBrandList = try await scrapeAPI.fetchScrapedBrands(email: userEmail)
//                    } catch {
//                        print("스크랩 브랜드 불러오기 실패: \(error)")
//                    }
//                }
//            }
//            // 상세 페이지 등 필요시 아래처럼 사용
//            // .navigationDestination(isPresented: $showBrandPage) {
//            //     if let brand = selectedBrand {
//            //         BrandPage(brand: brand)
//            //     }
//            // }
//        }
//    }
//}
//
//#Preview {
//    BrandScrapePage()
//}

import SwiftUI

struct BrandScrapePage: View {
    @State private var showSecondModal = false
    @State private var offsetY: CGFloat = 0
    @GestureState private var dragOffset: CGFloat = 0
    @StateObject private var viewModel = BrandViewModel()

    @StateObject private var scrapeAPI = ScrapeServerAPI()
    @State private var scrapedBrandList: [BrandCard] = []
    @State private var flippedID: Int? = nil
    @State private var currentPage: Int = 0

    @State private var selectedBrand: BrandCard? = nil
    @State private var showBrandPage: Bool = false

    private let itemsPerPage = 9

    // 3x3 그리드 포맷을 유지한 페이지 분할
    var pagedBrands: [[BrandCard?]] {
        stride(from: 0, to: scrapedBrandList.count, by: itemsPerPage).map { start in
            var slice = Array(scrapedBrandList[start..<min(start + itemsPerPage, scrapedBrandList.count)]).map { Optional($0) }
            while slice.count < itemsPerPage {
                slice.append(nil)
            }
            return slice
        }
    }

    // 삭제 및 서버 최신화 함수
    func deleteBrandCard(_ brand: BrandCard) {
        guard let userEmail = UserSessionManager.shared.emailString else { return }
        scrapeAPI.patchLike(email: userEmail, brandId: brand.brandId, isScraped: false) {
            DispatchQueue.main.async {
                scrapedBrandList.removeAll { $0.brandId == brand.brandId }
            }
            Task {
                do {
                    let newList = try await scrapeAPI.fetchScrapedBrands(email: userEmail)
                    DispatchQueue.main.async {
                        scrapedBrandList = newList
                    }
                } catch {
                    print("스크랩 목록 재로딩 실패: \(error)")
                }
            }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                Color.black.opacity(0.8).edgesIgnoringSafeArea(.all)
                Image("whaleBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .opacity(0.8)
                    .offset(x: 13)

                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.BackgroundBlue.opacity(0.8),
                        Color.black.opacity(0.8)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                ).ignoresSafeArea()

                VStack {
                    Text("My 디깅함")
                        .font(.custom("Pretendard-Bold", size: 15))
                        .foregroundColor(.white)
                        .padding(.top, 20)

                    Spacer().frame(height: 63)

                    Button(action: {
                        showSecondModal = true
                    }) {
                        Text("단계 레벨 가이드 보기")
                            .font(.custom("Pretendard-Light", size: 10))
                            .foregroundColor(.gray)
                            .underline()
                    }
                    .padding(.bottom, 10)
                    .padding(.leading, 230)

                    VStack {
                        if scrapedBrandList.isEmpty {
                            ZStack {
                                Color.clear
                                Text("아직 스크랩한 브랜드가 없어요.")
                                    .font(.custom("Pretendard-Regular", size: 12))
                                    .foregroundColor(.white.opacity(0.8))
                                    .multilineTextAlignment(.center)
                            }
                            .frame(height: 440)
                        } else {
                            TabView(selection: $currentPage) {
                                ForEach(0..<pagedBrands.count, id: \.self) { pageIndex in
                                    let brands = pagedBrands[pageIndex]
                                    VStack {
                                        ForEach(0..<3, id: \.self) { row in
                                            HStack(spacing: 11) {
                                                ForEach(0..<3, id: \.self) { col in
                                                    let index = row * 3 + col
                                                    if let brand = brands[index] {
                                                        BrandFlipCardView(
                                                            brand: brand,
                                                            flippedID: $flippedID,
                                                            onDelete: {
                                                                deleteBrandCard(brand)
                                                            },
                                                            onShop: {
                                                                selectedBrand = brand
                                                                showBrandPage = true
                                                            }
                                                        )
                                                    } else {
                                                        Color.clear
                                                    }
                                                }
                                                .frame(width: 99, height: 124)
                                            }
                                            if row < 2 {
                                                Rectangle()
                                                    .fill(Color.white.opacity(0.3))
                                                    .frame(height: 1)
                                                    .frame(width: 360)
                                                    .padding(.top, 17)
                                                    .padding(.bottom, 17)
                                            }
                                        }
                                    }
                                    .padding(.vertical, 30)
                                    .padding(.top, 30)
                                    .tag(pageIndex)
                                }
                                .padding(.top, 0)
                            }
                            .tabViewStyle(.page(indexDisplayMode: .never))
                            HStack(spacing: 8) {
                                ForEach(0..<pagedBrands.count, id: \.self) { index in
                                    Circle()
                                        .fill(index == currentPage ? Color.ScrollPoint : Color.nickBox)
                                        .frame(width: 8, height: 8)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 50)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.clear)
                            .overlay(
                                ZStack {
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color.Gradient1.opacity(0.5),
                                            Color.Gradient2.opacity(0.5),
                                            Color.Gradient3.opacity(0.5),
                                            Color.Gradient4.opacity(0.5),
                                            Color.Gradient5.opacity(0.5)
                                        ]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                    .opacity(0.5)
                                    .blur(radius: 0.3)

                                    Color.white.opacity(0.24)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            )
                    )
                    .overlay(
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.2), lineWidth: 2)
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.4), lineWidth: 0.8)
                        }
                    )
                    .shadow(color: Color.black.opacity(0.1), radius: 8, y: 2)
                    .opacity(0.9)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 50)

                    Spacer()
                }

                if showSecondModal {
                    SecondModalView(isVisible: $showSecondModal)
                }
            }
            .onAppear {
                offsetY = UIScreen.main.bounds.height - 100
                Task {
                    let userEmail = UserSessionManager.shared.emailString ?? ""
                    do {
                        scrapedBrandList = try await scrapeAPI.fetchScrapedBrands(email: userEmail)
                    } catch {
                        print("스크랩 브랜드 불러오기 실패: \(error)")
                    }
                }
            }
            // 상세 페이지 등 필요시 아래처럼 사용
            // .navigationDestination(isPresented: $showBrandPage) {
            //     if let brand = selectedBrand {
            //         BrandPage(brand: brand)
            //     }
            // }
        }
    }
}

#Preview {
    BrandScrapePage()
}
