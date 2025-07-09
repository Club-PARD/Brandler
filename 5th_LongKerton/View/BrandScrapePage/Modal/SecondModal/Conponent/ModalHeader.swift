////
////  ModalHeader.swift
////  5th_LongKerton
////
////  Created by 정태주 on 7/10/25.
////
//
//import SwiftUI
//
//struct ModalHeader: View {
//    var onClose: () -> Void
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            HStack {
//                Button(action: onClose) {
//                    Image(systemName: "xmark")
//                        .foregroundColor(.white)
//                        .padding()
//                }
//                Spacer()
//            }
//            
//            Text("단계 가이드")
//                .font(.custom("Pretendard-SemiBold", size: 15))
//                .foregroundColor(.white)
//                .padding(.bottom, 12)
//                .offset(y: -25)
//        }
//    }
//}
