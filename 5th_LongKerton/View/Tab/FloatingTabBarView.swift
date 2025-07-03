//
//  FloatingTabBarView.swift
//  5th_LongKerton
//
//  Created by Yehyuck Chi on 7/3/25.
//

import Foundation
import SwiftUI

struct FloatingTabBarView: View {
    var body: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.myHomeGray)
                .frame(width: 100, height: 36)
                .overlay(
                    Text("HOME")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.white)
                )
            Circle()
                .fill(Color.myHomeGray)
                .frame(width: 36, height: 36)
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.pageDarkBlue)
                .frame(width: 100, height: 36)
                .overlay(
                    Text("MY PAGE")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.pageBlue)
                )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        // Glassmorphism background
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 32, style: .continuous)
        )
        // Glassy border
        .overlay(
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .stroke(Color.white.opacity(0.25), lineWidth: 1)
        )
        // Soft shadow for floating effect
        .shadow(color: Color.black.opacity(0.10), radius: 8, y: 2)
        .padding(.bottom, 8)
    }
}
