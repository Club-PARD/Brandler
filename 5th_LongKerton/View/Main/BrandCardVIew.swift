//
//  BestBrandCardVIew.swift
//  5th_LongKerton
//
//  Created by Kim Kyengdong on 7/3/25.
//

import SwiftUI

struct BrandCardVIew:View {
    var brand: MockBrand
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 99, height: 124)
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
                    Image(brand.bannerImageName)
                        .resizable()
                        .frame(width: 99, height: 124)
                )
                .cornerRadius(12)
            HStack{
                Image(brand.logoImageName)
                    .resizable()
                    .frame(width: 14, height: 14)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(.white.opacity(0.3), lineWidth: 1)
                    )
                Text(brand.name)
                    .font(.custom("Pretendard-Medium", size: 10))
                    .foregroundColor(Color("BrandNameColor"))
                    .frame(minWidth: 64, maxWidth: 64, maxHeight: .infinity, alignment: .leading)
            }
            .frame(width: 81, height: 16, alignment: .leading)
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
//
//#Preview{
//    BestBrandCardVIew(brand: .sampleData[1])
//}
