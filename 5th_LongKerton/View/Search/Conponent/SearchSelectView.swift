//
//  SearchSelectView.swift
//  5th_LongKerton
//
//  Created by Kim Kyengdong on 7/9/25.
//

import SwiftUI

import SwiftUI

struct SearchSelectView: View {
    @Binding var selectedType: SearchType

    var body: some View {
        HStack {
            VStack {
                Button(action: {
                    selectedType = .brand
                }) {
                    Text("브랜드")
                        .font(.custom("Pretendard-Medium", size: 14))
                        .foregroundColor(selectedType == .brand ? Color("SelectedTab") : Color.EditBox)
                }
                if selectedType == .brand {
                    Rectangle()
                        .frame(width: 37, height: 1)
                        .foregroundColor(Color("SelectedTab"))
                }
            }

            Spacer().frame(width: 136)

            VStack {
                Button(action: {
                    selectedType = .product
                }) {
                    Text("상품")
                        .font(.custom("Pretendard-Medium", size: 14))
                        .foregroundColor(selectedType == .product ? Color("SelectedTab") : Color.EditBox)
                }
                if selectedType == .product {
                    Rectangle()
                        .frame(width: 37, height: 1)
                        .foregroundColor(Color("SelectedTab"))
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        SearchSelectView(selectedType: .constant(.brand))
            .padding()
    }
    .previewLayout(.sizeThatFits)
}
