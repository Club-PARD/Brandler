//
//  OnBoardNickNameView.swift
//  5th_LongKerton
//
//  Created by Yehyuck Chi on 6/30/25.
//

import SwiftUI


import SwiftUI

struct OnBoardNickNameView: View {
    @State private var nickname: String = ""
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer().frame(height: 24)
                
                GeometryReader { geometry in
                    let totalWidth = geometry.size.width
                    let progressWidth = totalWidth / 3
                    let squareSize: CGFloat = 28

                    VStack(spacing: 8) {
                        // Progress bar with square overlayed at the right end of the filled bar
                        ZStack(alignment: .leading) {
                            // Full bar
                            Capsule()
                                .fill(Color(white: 0.8))
                                .frame(height: 10)
                            // Filled bar (1/3)
                            Capsule()
                                .fill(Color(white: 0.4))
                                .frame(width: progressWidth, height: 10)
                            
                            // Small square on top right of filled bar
                            Rectangle()
                                .fill(Color(white: 0.8))
                                .frame(width: squareSize, height: squareSize)
                                .cornerRadius(4)
                                .offset(x: progressWidth - squareSize / 2, y: -squareSize * 0.9)
                        }
                        .frame(height: squareSize + 10) // enough height for square and bar
                    }
                    .frame(width: totalWidth)
                }
                .frame(height: 56)
                .padding(.horizontal, 36)
                .padding(.bottom, 36)
            

                
                // 1번 단계 아이콘
                HStack {
                    Circle()
                        .fill(Color(white: 0.95))
                        .frame(width: 32, height: 32)
                        .overlay(
                            Text("1")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.gray)
                        )
                    Spacer()
                }
                .padding(.leading, 36)
                .padding(.bottom, 12)
                
                // 타이틀
                HStack {
                    Text("닉네임을 설정해주세요")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.leading, 36)
                .padding(.bottom, 36)
                
                // "닉네임" 라벨
                HStack {
                    Text("닉네임")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.leading, 36)
                .padding(.bottom, 6)
                
                // 닉네임 입력 필드
                HStack {
                    ZStack(alignment: .leading) {
                        if nickname.isEmpty {
                            Text("닉네임을 입력해주세요")
                                .foregroundColor(Color.white.opacity(0.5))
                                .font(.system(size: 17))
                                .padding(.leading, 20)
                        }
                        TextField("", text: $nickname)
                            .foregroundColor(.white)
                            .font(.system(size: 17))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 18)
                    }
                    .background(Color(white: 0.15))
                    .cornerRadius(16)
                }
                .padding(.horizontal, 36)
                .padding(.bottom, 0)
                
                Spacer()
                
                // 하단 버튼
                Button(action: {
                    // 다음 단계로 이동
                }) {
                    Text("다음으로")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 56)
                        .background(Color(white: 0.7))
                        .cornerRadius(28)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
            }
        }
    }
}

#Preview {
    OnBoardNickNameView()
}

