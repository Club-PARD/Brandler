
import SwiftUI

struct BrandScrapePage: View {
    @State private var showSecondModal = false
    @State private var offsetY: CGFloat = 0
    @GestureState private var dragOffset: CGFloat = 0
    @StateObject private var viewModel = BrandViewModel()
    @Binding var currentState: AppState
    @Binding var previousState: AppState
    
    
    @StateObject private var scrapeAPI = ScrapeServerAPI()
    @State private var scrapedBrandList: [BrandCard] = []
    @State private var flippedID: Int? = nil
    @State private var currentPage: Int = 0
    
    @State private var selectedBrand: BrandCard? = nil
    @State private var showBrandPage: Bool = false
    
    private let itemsPerPage = 9
    
    var pagedBrands: [[BrandCard?]] {
        stride(from: 0, to: scrapedBrandList.count, by: itemsPerPage).map { start in
            var slice = Array(scrapedBrandList[start..<min(start + itemsPerPage, scrapedBrandList.count)]).map { Optional($0) }
            while slice.count < itemsPerPage {
                slice.append(nil)
            }
            return slice
        }
    }
    
    func deleteBrandCard(_ brand: BrandCard) {
        guard let userEmail = UserSessionManager.shared.emailString else { return }
        flippedID = nil
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
//    
//    /// ⭐️ 복잡한 뷰를 함수로 분리하여 타입 추론 오류 방지
//    @ViewBuilder
//    func buildPageView(for brands: [BrandCard?]) -> some View {
//        VStack {
//            ForEach(0..<3, id: \.self) { row in
//                HStack(spacing: 11) {
//                    ForEach(0..<3, id: \.self) { col in
//                        let index = row * 3 + col
//                        if let brand = brands[index] {
//                            BrandFlipCardView(currentState: $currentState, previousState: $previousState,
//                                              brand: brand,
//                                              flippedID: $flippedID,
//                                              onDelete: {
//                                deleteBrandCard(brand)
//                            }
//                            )
//                        } else {
//                            Color.clear
//                        }
//                    }
//                    .frame(width: 99, height: 124)
//                }
//                if row < 2 {
//                    Rectangle()
//                        .fill(Color.white.opacity(0.3))
//                        .frame(height: 1)
//                        .frame(width: 360)
//                        .padding(.vertical, 17)
//                }
//            }
//        }
//        .padding(.vertical, 30)
//        .padding(.top, 30)
//    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                BackgroundView()
                
                VStack {
                    HeaderView {
                        showSecondModal = true
                    }
                    
                    ScrapedBrandGridView(
                        scrapedBrandList: scrapedBrandList,
                        pagedBrands: pagedBrands,
                        currentPage: $currentPage,
                        flippedID: $flippedID,
                        onDelete: deleteBrandCard,
                        onSelect: { brand in
                            selectedBrand = brand
                            showBrandPage = true
                        }
                    )
                    
                    Spacer()
                }
                
                if showSecondModal {
                    SecondModalView(isVisible: $showSecondModal)
                }
            }
            .onAppear{
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
        }
    }
}
