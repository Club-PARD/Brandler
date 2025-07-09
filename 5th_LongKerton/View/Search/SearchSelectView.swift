//
//  SearchSelectView.swift
//  5th_LongKerton
//
//  Created by Kim Kyengdong on 7/9/25.
//

import SwiftUI

struct SearchSelectView: View {
    @State private var selectedToSearch:String = "브랜드"    //true=브랜드, false=상품
    var body: some View {
        HStack{
            VStack{
                Button(action:{
                    selectedToSearch = "브랜드"
                }){Text("브랜드")
                        .font(.custom("Pretendard-Medium",size:14))
                        .foregroundColor(selectedToSearch == "브랜드" ? Color("SelectedTab"):Color.EditBox)
                }
                if selectedToSearch=="브랜드"{
                    Rectangle()
                      .foregroundColor(.clear)
                      .frame(width: 37, height: 1)
                      .background(Color("SelectedTab"))
                }
            }
            Spacer()
                .frame(width:136)
            VStack{
                Button(action:{
                    selectedToSearch = "상품"
                }){Text("상품")
                        .font(.custom("Pretendard-Medium",size:14))
                        .foregroundColor(selectedToSearch == "상품" ? Color("SelectedTab"):Color.EditBox)
                }
                if selectedToSearch=="상품"{
                    Rectangle()
                      .foregroundColor(.clear)
                      .frame(width: 37, height: 1)
                      .background(Color("SelectedTab"))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        
    }
}


#Preview {
    ZStack {
        Color.black.ignoresSafeArea() // 배경색 설정 (원하는 색상으로 변경 가능)
        SearchSelectView()
            .padding()
    }
    .previewLayout(.sizeThatFits)
}
