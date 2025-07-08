//
//  BrandFilterView.swift
//  5th_LongKerton
//
//  Created by Kim Kyengdong on 7/4/25.
//

import SwiftUI

struct BrandFilterView: View{
    let brands: [Brand]
    var selectedGenre: String = "전체"
    
    var filteredBrands: [Brand] {
        selectedGenre == "전체"
        ? brands
        : brands.filter { $0.brandGenre == selectedGenre }
    }
    
    var body: some View{
        LazyVGrid(columns: Array(repeating: GridItem(.fixed(173)), count: 2), spacing: 10) {
            ForEach(filteredBrands) { brand in
                NavigationLink(destination: BrandPage(brand: brand)) {
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 173, height: 252)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color("CardGradiantblack").opacity(0),
                                        Color("CardGradiant").opacity(0.7)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .background(
                                Image(brand.brandBannerUrl)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 173, height: 252)
                            )
                            .cornerRadius(12)
                        HStack(spacing:0){
                            Image(brand.brandLogoUrl)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .clipShape(Circle())
                                .padding(.leading,3)
                            VStack(alignment:.center){
                                Text(brand.name)
                                    .font(.custom("Pretendard-Medium", size: 17))
                                    .foregroundColor(Color("BrandNameColor"))
                                    .lineLimit(1)
                            }
                            .frame(width:112)
                        }
                        .frame(width: 147, height: 31, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color("BrandGroupColor"))
                                .stroke(Color("BrandNameColor"), lineWidth: 2)
                        )
                        .padding(.bottom, 8)
                        
                    }
                }
            }
        }
        .padding(0)
    }
}

#Preview{
    BrandFilterView(brands: Brand.sampleData)
}
