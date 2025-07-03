//
//  MainPage.swift
//  5th_LongKerton
//
//  Created by Kim Kyengdong on 6/30/25.
//

import SwiftUI

struct MainPage: View {
    @StateObject private var viewModel = BrandScrapeViewModel()
////    @StateObject private var brandModel = BrandViewModel()
    @State public var selectedGenre: String = "페미닌"
    private var toggleGenre: Bool = false
    
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: - Header
                    HStack {
                        Image("Logo")
                            .resizable()
                            .frame(width:98,height:33)
                        Spacer()
                        
                        
                        Text("장마엔 종로룩 완성 님 반가워요")
                            .foregroundColor(.white)
                            .font(.footnote)
                            .padding(.horizontal)
                    }
                    
                    HStack{
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .medium))
                    }
                    // MARK: - Banner Image
                    ZStack(alignment: .bottomLeading){
                        Image("Ocean")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 160)
                            .clipped()
                            .cornerRadius(12)
                        
                        Text("깊은 곳에서 시작됩니다.\n브랜드, 그리고 당신의 취향")
                            .foregroundColor(.white)
                            .font(.system(size: 25,weight:.light))
                            .padding()
                        
                    }
                    
                    // MARK: - Section Title
                    HStack{
                        VStack(alignment: .leading, spacing: 2) {
                            Text("요즘 디깅러들이 탐험하는")
                                .foregroundColor(Color("TextColor1"))
                                .font(.headline)
                            Text("최근 3주간 가장 많이 탐험된 브랜드")
                                .foregroundColor(.white)
                                .font(.caption)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color(.darkGray))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(.blue), lineWidth: 1)
                    )
                    
                    // MARK: - Brand Grid Placeholder
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.brands) { brand in
                                NavigationLink(destination: BrandDetailView(brand: brand)) {
                                    VStack {
                                        Image(brand.logoImageName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 60, height: 60)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                            .shadow(radius: 2)
                                        
                                        Text(brand.name)
                                            .font(.caption)
                                            .lineLimit(1)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 8)
                    
                    // MARK: - Blue Banner
                    VStack(alignment: .leading, spacing: 6) {
                        Text("디깅러 취향 저격 리스트")
                            .foregroundColor(.white)
                            .font(.headline)
                        Text("#취향 있는 디깅러라면 놓치지 않을 브랜드들.")
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                    .padding()
                    .cornerRadius(9)
                    
                    GenreFilterView(selectedFilter:$selectedGenre)
                    // MARK: - Filter + 전체 버튼
                    HStack {
                        
                        Spacer()
                        
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(.white)
                    }
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
                        ForEach(viewModel.filteredBrands) { brand in
                            NavigationLink(destination: BrandDetailView(brand: brand)) {
                                VStack {
                                    Image(brand.logoImageName)
                                        .resizable()
                                        .foregroundColor(.clear)
                                        .frame(width: 173, height: 252)
                                        .cornerRadius(11.59348)
                                    
                                    Text(brand.name)
                                        .font(.caption)
                                        .lineLimit(1)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, 80)
            }
        }
        .padding(.horizontal, 10)
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    MainPage()
}
