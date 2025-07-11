import SwiftUI

struct MainPage: View {
    @ObservedObject private var session = UserSessionManager.shared
    
    @StateObject private var viewModel = BrandViewModel()
    @StateObject private var getViewModel = GetBrandListViewModel()
    @State private var top10List: [BrandCard] = []
    @State private var sortedList: [GenreBrandCard] = []
    
    @State public var selectedGenre: String = UserSessionManager.shared.userData?.fashionGenre ?? "전체"
    
    @State private var previousScrapeCount: Int = UserDefaults.standard.integer(forKey: "previousScrapeCount")
    @State private var currentScrapeCount: Int = 0
    @State private var scrapeStatusMessage: String? = nil
    
    @State private var togglemesage: Bool = false
    @State private var toggleGenre: Bool = false
    @State public var bannerData = [
        Banner(imageName: "배너1번", titleLine1: "지금 당신이 찾는 프레피룩,", titleLine2: "여기에 다 있다"),
        Banner(imageName: "배너2번", titleLine1: "2025 S/S 스타일 가이드", titleLine2: "취향을 발견해보세요"),
        Banner(imageName: "배너3번", titleLine1: "다음 계절을 준비하는 법", titleLine2: "클릭 한 번으로 완성"),
        Banner(imageName: "배너4번", titleLine1: "지금 당신이 찾는 프레피룩,", titleLine2: "여기에 다 있다"),
        Banner(imageName: "배너5번", titleLine1: "2025 S/S 스타일 가이드", titleLine2: "취향을 발견해보세요"),
        Banner(imageName: "배너6번", titleLine1: "다음 계절을 준비하는 법", titleLine2: "클릭 한 번으로 완성"),
        Banner(imageName: "배너7번", titleLine1: "지금 당신이 찾는 프레피룩,", titleLine2: "여기에 다 있다"),
        Banner(imageName: "배너8번", titleLine1: "2025 S/S 스타일 가이드", titleLine2: "취향을 발견해보세요"),
        Banner(imageName: "배너9번", titleLine1: "다음 계절을 준비하는 법", titleLine2: "클릭 한 번으로 완성"),
        Banner(imageName: "배너10번", titleLine1: "지금 당신이 찾는 프레피룩,", titleLine2: "여기에 다 있다"),
        Banner(imageName: "배너11번", titleLine1: "2025 S/S 스타일 가이드", titleLine2: "취향을 발견해보세요")
    ]
    
    @Binding var currentState: AppState
    @Binding var previousState: AppState
    
    // MARK: - 레벨 변환 함수 (0~4: 1단계, 5~9: 2단계, ... 20+: 5단계)
    private func scrapeCountToLevel(_ scrapeCount: Int) -> Int {
        let level = scrapeCount / 5 + 1
        return min(level, 5)
    }
    
    // MARK: - 레벨 업/다운 메시지 생성 함수
    private func generateScrapeStatusMessage(oldScrape: Int, newScrape: Int) -> String? {
        let oldLevel = scrapeCountToLevel(oldScrape)
        let newLevel = scrapeCountToLevel(newScrape)
        if newLevel > oldLevel {
            return "\(newLevel)단계로 레벨 업!✨"
        } else if newLevel < oldLevel {
            return "\(newLevel)단계로 레벨 다운💦"
        } else {
            return nil
        }
    }
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                HStack {
                    Image("brandler")
                        .resizable()
                        .scaledToFill()
                        .frame(width:108,height:38)
                    Spacer()
                    Button(action:{
                        previousState = currentState
                        currentState = .search
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color("SearchingIconColor"))
                            .font(.system(size: 20, weight: .medium))
                    }
                }
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading) {
                        // MARK: - Banner Image
                        BannerCarouselView(
                            banners: bannerData,
                            scrapeStatusMessage: scrapeStatusMessage // 메시지 전달
                        )
                        .padding(.top, 33)
                        .padding(.bottom, 29)
                        
                        // MARK: - Section Title
                        HStack{
                            VStack(alignment: .leading, spacing: 2) {
                                Text("디깅러들의 브랜드 픽")
                                    .foregroundColor(.white)
                                    .font(.custom("Pretendard-Bold",size: 15))
                                Text("최근 3주간 급상승한 브랜드에요!")
                                    .foregroundColor(.gray)
                                    .font(.custom("Pretendard-Medium",size: 11))
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 14)
                        
                        // MARK: - Brand Grid Placeholder
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(top10List, id:\.brandId){ brand in
                                    Button(action:{
                                        viewModel.currentBrandId = brand.brandId
                                        previousState = currentState
                                        currentState = .brand
                                    }) {
                                        BrandCardView(brand: brand)
                                    }
                                }
                            }
                        }
                        .padding(.leading, 20)
                        .padding(.bottom,50)
                        
                        // MARK: - Blue Banner
                        ZStack(alignment: .bottomLeading) {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 188, height: 6)
                                .background(Color(red: 0, green: 0.21, blue: 1))
                                .cornerRadius(2)
                            Text("디깅러 취향 저격 리스트")
                                .foregroundColor(.white)
                                .font(.Pretendard_Bold)
                        }
                        .padding(.horizontal, 20)
                        
                        GenreFilterView(selectedFilter: $selectedGenre)
                            .padding(.horizontal, 20)
                        
                        // MARK: - Filter + 전체 버튼
                        VStack {
                            HStack {
                                Spacer()
                                Button(action: {
                                    togglemesage.toggle()
                                }) {
                                    Image(systemName: "questionmark.circle")
                                        .foregroundColor(Color("SearchingIconColor"))
                                }
                            }
                            .padding(.trailing,20)
                            
                            ZStack (alignment: .topTrailing){
                                BrandFilterView(viewModel: viewModel, currentState: $currentState, previousState: $previousState, brands: sortedList, selectedGenre: selectedGenre)
                                    .padding(.horizontal, 20)
                                if togglemesage {
                                    ZStack(alignment:.topTrailing){
                                        Text("스크랩 수가 적은 브랜드 순으로 \n정렬되어있어요.")
                                            .font(.custom("Pretendard-Medium", size: 9))
                                            .foregroundColor(Color(red: 0.81, green: 0.81, blue: 0.81))
                                            .foregroundColor(.clear)
                                            .frame(width: 157, height: 40)
                                            .background(Color(red: 0.22, green: 0.22, blue: 0.22))
                                            .cornerRadius(9)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 9)
                                                    .inset(by: 0.5)
                                                    .stroke(Color(red: 0.54, green: 0.54, blue: 0.54), lineWidth: 1)
                                            )
                                        Button(action: {
                                            togglemesage.toggle()
                                        }) {
                                            Image("CloseButton")
                                                .resizable()
                                                .frame(width:9,height:9)
                                                .padding(.vertical,5)
                                                .padding(.horizontal,6)
                                        }
                                    }
                                    .padding(.trailing,19)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 80)
                }
            }
            .task {
                do {
                    top10List = try await getViewModel.getTop10List()
                    if let email = session.userData?.email {
                        sortedList = try await getViewModel.getSortedList(email)
                        
                        // 현재 스크랩 수 GET
                        let scrapeCount = await fetchScrapeCount(email: email)
                        currentScrapeCount = scrapeCount
                        
                        // 메시지 결정 로직 (레벨 시스템 적용)
                        scrapeStatusMessage = generateScrapeStatusMessage(
                            oldScrape: previousScrapeCount,
                            newScrape: currentScrapeCount
                        )
                    }
                } catch {
                    print("❌ Get Error: \(error)")
                }
            }
            .onDisappear {
                Task {
                    if let email = session.userData?.email {
                        let scrapeCount = await fetchScrapeCount(email: email)
                        previousScrapeCount = scrapeCount
                        UserDefaults.standard.set(scrapeCount, forKey: "previousScrapeCount")
                    }
                }
            }
        }
        .background(Color.BgColor.edgesIgnoringSafeArea(.all))
    }
    
    // 서버에서 스크랩 수를 받아오는 함수
    private func fetchScrapeCount(email: String) async -> Int {
        do {
            let scrapedList = try await getViewModel.getScrapList(email)
            return scrapedList.count
        } catch {
            print("❌ 스크랩 수 불러오기 실패: \(error)")
            return 0
        }
    }
}
