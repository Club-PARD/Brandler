//
//  LiquidGlassView.swift
//  LiquidGlass
//
//  Created by 정태주 on 6/29/25.
//

import SwiftUI

struct LiquidGlassView: View {
    @State private var animate = false

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            RoundedRectangle(cornerRadius: 30)
                .fill(.ultraThinMaterial)
                .frame(width: 300, height: 200)
                .overlay(
                    WaveOverlay(animate: $animate)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .opacity(0.2)
                )
                .shadow(color: .white.opacity(0.3), radius: 10, x: 0, y: 0)
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 3).repeatForever(autoreverses: false)) {
                animate = true
            }
        }
    }
}

#Preview {
    LiquidGlassView()
}
