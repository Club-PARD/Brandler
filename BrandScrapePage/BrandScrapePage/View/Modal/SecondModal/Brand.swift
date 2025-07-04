//
//  Brand.swift
//  BrandScrapePage
//
//  Created by 정태주 on 7/3/25.
//
import SwiftUI

@ViewBuilder
func BrandStepView(step: Int) -> some View {
    HStack(spacing: 16) {
        Spacer()
        VStack(spacing: 8) {
            Text("\(step)단계")
                .font(.headline)
                .foregroundColor(.black)

            RoundedRectangle(cornerRadius: 8)
                .fill(Color.NickWhite)
                .frame(width: 60, height: 60)

            Text("스크랩 수 기준")
                .font(.caption)
                .foregroundColor(.black.opacity(0.6))
        }
        .frame(maxWidth: .infinity)
        
        Spacer()
    }
    .padding(.horizontal, 10)
    .frame(height: 130)
    .frame(maxWidth: .infinity)
    .background(
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
    )
}
