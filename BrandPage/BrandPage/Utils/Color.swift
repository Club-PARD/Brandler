//
//  Color.swift
//  BrandPage
//
//  Created by 정태주 on 7/2/25.
//

import SwiftUI

extension Color {
    
    /// HEX 문자열 → Color
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)

        let r, g, b: UInt64
        switch hex.count {
        case 6: // RGB (24-bit)
            (r, g, b) = ((int >> 16) & 0xff, (int >> 8) & 0xff, int & 0xff)
        default:
            (r, g, b) = (1, 1, 1) // fallback: white
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: 1
        )
    }

    /// HEX 간 보간: 시작 Hex → 끝 Hex → 진행도 → 보간된 Color
    static func interpolateHex(from startHex: String, to endHex: String, fraction: CGFloat) -> Color {
        func hexToRGB(_ hex: String) -> (CGFloat, CGFloat, CGFloat) {
            let scanner = Scanner(string: hex)
            if hex.hasPrefix("#") {
                scanner.currentIndex = hex.index(after: hex.startIndex)
            }

            var rgbValue: UInt64 = 0
            scanner.scanHexInt64(&rgbValue)

            let r = CGFloat((rgbValue & 0xFF0000) >> 16)
            let g = CGFloat((rgbValue & 0x00FF00) >> 8)
            let b = CGFloat(rgbValue & 0x0000FF)

            return (r, g, b)
        }

        func lerp(_ a: CGFloat, _ b: CGFloat) -> CGFloat {
            return a + (b - a) * fraction
        }

        let (r1, g1, b1) = hexToRGB(startHex)
        let (r2, g2, b2) = hexToRGB(endHex)

        return Color(
            red: lerp(r1, r2) / 255.0,
            green: lerp(g1, g2) / 255.0,
            blue: lerp(b1, b2) / 255.0
        )
    }
}
