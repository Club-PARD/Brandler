//
//  ContentView.swift
//  ScrapBar
//
//  Created by 정태주 on 6/29/25.
//

import SwiftUI

struct ScrapProgressBar: View {
    var currentScrap: Int
    var maxScrap: Int

    private var progress: CGFloat {
        guard maxScrap > 0 else { return 0 }
        return CGFloat(currentScrap) / CGFloat(maxScrap)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("스크랩 \(currentScrap)/\(maxScrap)")
                .font(.headline)

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 20)
                        .foregroundColor(Color.gray.opacity(0.2))

                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: geometry.size.width * progress, height: 20)
                        .foregroundColor(.blue)
                        .animation(.easeInOut, value: progress)
                }
            }
            .frame(height: 20)
        }
    }
}
