//
//  SecondCustomModalView.swift
//  BSPModal
//
//  Created by 정태주 on 6/30/25.
//

import SwiftUI

struct SecondModalView: View {
    @Binding var isVisible: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()

            VStack(spacing: 20) {
                Text("두 번째 모달입니다")
                    .font(.largeTitle)
                    .foregroundColor(.white)

                Button("닫기") {
                    isVisible = false
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
            }
        }
        .transition(.move(edge: .bottom))
        .zIndex(10)
    }
}
