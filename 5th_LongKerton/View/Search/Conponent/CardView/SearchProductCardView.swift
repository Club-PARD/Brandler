//
//  SearchProductCardView.swift
//  5th_LongKerton
//
//  Created by 정태주 on 7/9/25.
//

import SwiftUI

struct SearchProductCardView: View {
    let product: SearchProduct
    let width: CGFloat = 173
    let height: CGFloat = 252
    let cornerRadius: CGFloat = 12

    var body: some View {
        ZStack(alignment: .bottom) {
            // ✅ 배경 이미지 + 그라디언트
            ZStack {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: width, height: height)
                    .background(
                        Image(product.productImageUrl)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width, height: height)
                    )
                    .cornerRadius(cornerRadius)

                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("CardGradiantblack").opacity(0),
                        Color("CardGradiant").opacity(0.7)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(width: width, height: height)
                .cornerRadius(cornerRadius)
            }
            .clipped()

            // ✅ 상품명 + 가격 텍스트
            VStack(alignment: .center, spacing: 10) {
                Text(product.name)
                    .font(.custom("Pretendard-Medium", size: 12))
                    .foregroundColor(.white)
                    .opacity(1.0)
                    .frame(width: 94, height: 19)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.ProductBackGround) // 배경색
                            .opacity(0.3)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white, lineWidth: 1) // 테두리
                            .opacity(0.3)
                    )

                Text("KRW \(product.price.formatted())원")
                    .font(.custom("Pretendard-Regular", size: 12))
                    .foregroundColor(.white)
                    .opacity(0.7)
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
            .frame(width: width, alignment: .center)
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()

        SearchProductCardView(product: SearchProduct.brandItems[0])
    }
    .previewLayout(.sizeThatFits)
}
