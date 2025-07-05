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
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
            ForEach(filteredBrands) { brand in
                NavigationLink(destination: BrandPage(brand: brand)) {
                    ZStack(alignment: .bottom) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 173, height: 252)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.black.opacity(0),
                                        Color.blue.opacity(0.1),
                                        Color.blue.opacity(0.7)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .background(
                                    Image(brand.brandBannerUrl)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                            )
                            .cornerRadius(12)
                        HStack{
                            Image(brand.brandLogoUrl)
                                .resizable()
                                .frame(width: 14, height: 14)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(.white.opacity(0.3), lineWidth: 1)
                                )
                            VStack(alignment:.center){
                                Text(brand.name)
                                    .font(.custom("Pretendard-Medium", size: 10))
                                    .foregroundColor(Color("BrandNameColor"))
                            }
                            .frame(maxWidth:.infinity)
                        }
                        .frame(width: 140, height: 16, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color("BrandGroupColor"))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color("BrandNameColor"), lineWidth: 1)
                        )
                        .padding(.bottom, 8)
                        
                    }
                }
            }
        }
    }
}

#Preview{
    BrandFilterView(brands: Brand.sampleData)
}
