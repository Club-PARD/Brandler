//
//  WaveOverlay.swift
//  LiquidGlass
//
//  Created by 정태주 on 6/29/25.
//

import SwiftUI

struct WaveOverlay: View {
    @Binding var animate: Bool

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.white.opacity(0.5),
                Color.clear
            ]),
            startPoint: animate ? .topLeading : .bottomTrailing,
            endPoint: animate ? .bottomTrailing : .topLeading
        )
    }
}

#Preview {
    WaveOverlay(animate: .constant(true))
        .frame(width: 300, height: 200)
}
