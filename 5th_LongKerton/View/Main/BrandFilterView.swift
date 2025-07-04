//
//  BrandFilterView.swift
//  5th_LongKerton
//
//  Created by Kim Kyengdong on 7/4/25.
//

import SwiftUI

struct BrandFilterView: View{
    let brands: [MockBrand]
    var selectedGenre: String = "전체"
    
    var filteredBrands: [MockBrand] {
        selectedGenre == "전체"
        ? brands
        : brands.filter { $0.genre == selectedGenre }
    }
    
    var body: some View{
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 10) {
            ForEach(filteredBrands) { brand in
                NavigationLink(destination: BrandDetailView(brand: brand)) {
                    VStack {
                        Image(brand.logoImageName)
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

