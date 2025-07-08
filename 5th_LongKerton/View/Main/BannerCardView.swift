//
//  BannerCardView.swift
//  5th_LongKerton
//
//  Created by Kim Kyengdong on 7/3/25.
//
import SwiftUI

struct BannerCardView: View {
    let banner: Banner
    let index: Int
    let total: Int
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            Image(banner.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:.infinity, height: 160)
                .clipped()
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color("CardGradiantblack").opacity(0.3),
                            Color("CardGradiantblack").opacity(0.8)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .cornerRadius(12)
            
            
            HStack(alignment: .bottom){
                VStack(alignment: .leading) {
                    Text(banner.titleLine1)
                        .font(.custom("Pretendard-SemiBold",size: 15))
                    Text(banner.titleLine2)
                        .font(.custom("Pretendard-SemiBold",size: 15))

                }
                .foregroundColor(Color("BannerTextColor1"))
                .padding(.horizontal,7)
                
                Spacer()
                
                Text("\(index + 1)/\(total)")
                    .font(.custom("Pretendard-Medium",size: 10))
                    .foregroundColor(Color("MainBannerNumColor"))
                    .frame(width:33,height:18)
                    .background(Color("MainBannerNumBackColor").opacity(0.2))
                    .clipShape(Capsule())
                    .padding(.horizontal,9)
            }
            .padding(10)
        }
        .frame(width:.infinity, height: 160)
    }
}
