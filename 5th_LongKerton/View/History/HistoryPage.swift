//
//  HistoryView.swift
//  5th_LongKerton
//
//  Created by Kim Kyengdong on 7/2/25.
//

import SwiftUI

struct HistoryPage: View {
    var History :[MockBrand]=MockBrand.sampleData
    var body: some View{
        VStack{
            Text("최근 본 브랜드")
            ScrollView{
                VStack(alignment: .leading){
                    ForEach(History) { history in
                        HStack{
                            Image(history.logoImageName)
                                .resizable()
                                .frame(width: 50,height: 50)
                            Text(history.name)
                        }
                    }
                }
                .frame(width:.infinity)
                .padding(.horizontal,10)
            }
        }
    }
}

#Preview{
    HistoryPage()
}
