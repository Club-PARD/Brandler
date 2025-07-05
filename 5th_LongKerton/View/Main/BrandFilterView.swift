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
            ForEach(filteredBrands) { brands in
                NavigationLink(destination: BrandPage(brand: brands)) {
                    VStack {
                        Image(brands.brandLogoUrl)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 173, height: 252)
                            .cornerRadius(12)

                    }
                }
            }
        }
    }
}

