//
//  MainPage.swift
//  5th_LongKerton
//
//  Created by Kim Kyengdong on 6/30/25.
//

import SwiftUI

struct MainPage: View {
    @ObservedObject private var session = UserSessionManager.shared

    @StateObject private var viewModel = BrandViewModel()

////    @StateObject private var brandModel = BrandViewModel()
    //@State public var selectedGenre: String = "빈티지"
    @State public var selectedGenre: String = UserSessionManager.shared.userData?.fashionGenre ?? "전체"

    

    @State private var togglemesage: Bool = false
    private var toggleGenre: Bool = false
    @State public var bannerData = [
        Banner(imageName: "mockBanner1", titleLine1: "지금 당신이 찾는 프레피룩,", titleLine2: "여기에 다 있다"),
        Banner(imageName: "mockBanner2", titleLine1: "2025 S/S 스타일 가이드", titleLine2: "취향을 발견해보세요"),
        Banner(imageName: "mockBanner2", titleLine1: "다음 계절을 준비하는 법", titleLine2: "클릭 한 번으로 완성"),
    ]
    
    
    var body: some View {
        VStack {
            HStack {
                Image("brandler")
                    .resizable()
                    .scaledToFit()
                    .frame(width:98,height:33)
                Spacer()
                
                NavigationLink(destination: SearchView())
                {
                    
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color("SearchingIconColor"))
                        .font(.system(size: 20, weight: .medium))
                }
            }
            .padding(.bottom,2)
            .padding(.horizontal, 20)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: - Banner Image
                    BannerCarouselView(banners: bannerData)
                        .padding(.leading, 20)
                        .padding(.trailing, 15)
                    
                    
                    // MARK: - Section Title
                    HStack{
                        VStack(alignment: .leading, spacing: 2) {
                            Text("디깅러들의 브랜드 픽")
                                .foregroundColor(.white)
                                .font(.custom("Pretendard-Bold.ttf",size: 15))
                            Text("최근 3주간 급상승한 브랜드에요!")
                                .foregroundColor(.gray)
                                .font(.custom("Pretendard-Medium.ttf",size: 11))
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    // MARK: - Brand Grid Placeholder
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.brands) { brand in
                                NavigationLink(destination: BrandPage(brand: brand)) {
                                    BrandCardVIew(brand: brand)
                                }
                            }
                        }
                    }
                    .padding(.leading, 20)
                    
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
                                    .foregroundColor(.white)
                            }
                        }
                        
                        ZStack (alignment: .topTrailing){
                            BrandFilterView(brands: viewModel.brands, selectedGenre: selectedGenre)
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
                                    Image("CloseButton")
                                        .resizable()
                                        .frame(width:9,height:9)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 80)
            }
        }
        .background(Color.BgColor.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    MainPage()
}
