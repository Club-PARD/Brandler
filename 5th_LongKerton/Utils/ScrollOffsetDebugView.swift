//
//  ScrollOffsetDebugView.swift
//  BrandPage
//
//  Created by 정태주 on 7/4/25.
//

import SwiftUI

struct ScrollOffsetDebugView: View {
    let scrollOffset: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("🟦 scrollOffset: \(Int(scrollOffset))")
                .font(.system(size: 14, weight: .semibold))
            // 필요한 다른 오프셋 값도 표시 가능
        }
        .padding(10)
        .background(Color.blue.opacity(0.8))
        .foregroundColor(.white)
        .cornerRadius(10)
        .padding(.horizontal)
        .shadow(radius: 5)
    }
}
