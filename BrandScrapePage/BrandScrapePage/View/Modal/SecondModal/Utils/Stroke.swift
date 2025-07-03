//
//  Stroke.swift
//  BrandScrapePage
//
//  Created by 정태주 on 7/3/25.
//

// SecondModalView.swift
import SwiftUI

struct CustomCornerStrokeOverlay: View {
    var radius: CGFloat
    var corners: [Corner]
    var strokeColor: Color = .white
    var lineWidth: CGFloat = 1
    var maskOverlayHeight: CGFloat? = nil
    var maskOverlayColor: Color? = nil

    var body: some View {
        ZStack(alignment: .topLeading) {
            CustomRoundedCorner(radius: radius, corners: corners)
                .stroke(strokeColor, lineWidth: lineWidth)

            if let height = maskOverlayHeight, let color = maskOverlayColor {
                Rectangle()
                    .fill(color)
                    .frame(height: height)
            }
        }
    }
}
