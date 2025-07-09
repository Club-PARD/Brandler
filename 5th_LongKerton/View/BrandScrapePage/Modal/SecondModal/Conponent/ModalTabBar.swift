////
////  ModalTabBar.swift
////  5th_LongKerton
////
////  Created by 정태주 on 7/10/25.
////
//
//import SwiftUI
//
//struct ModalTabBar: View {
//    @Binding var selectedTab: Int
//    
//    var body: some View {
//        HStack(alignment: .top, spacing: 8) {
//            TabButton(title: "디깅러", selected: selectedTab == 0) {
//                selectedTab = 0
//            }
//            TabButton(title: "브랜드", selected: selectedTab == 1) {
//                selectedTab = 1
//            }
//        }
//        .font(.custom("Pretendard-Medium", size: 12))
//        .padding(.horizontal, 19)
//        .frame(height: 56)
//        .padding(.top, 20)
//        .foregroundColor(Color.white)
//    }
//}
