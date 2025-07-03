//
//  BrandPageViewModel.swift
//  BrandPage
//

import SwiftUI

enum Category: String, CaseIterable, Identifiable {
    case all = "전체"
    case top = "상의"
    case bottom = "하의"
    case accessory = "악세사리"

    var id: String { rawValue }
}

final class BrandPageViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var scrollOffset: CGFloat = 0
    @Published var selectedCategory: Category = .all
    @Published var items: [BrandItem] = [
        .init(frontImageName: "sample1", name: "루즈핏 후드", price: 49000, category: .top),
        .init(frontImageName: "sample2", name: "벌룬 니트", price: 59000, category: .top),
        .init(frontImageName: "sample3", name: "크롭 점퍼", price: 71000, category: .top),
        .init(frontImageName: "sample4", name: "기모 팬츠", price: 48000, category: .bottom)
    ]

    // MARK: - Constants
    let bannerHeight: CGFloat = 500
    let blurredBannerHeight: CGFloat = 700
    let holeSize = CGSize(width: 131, height: 413)

    // MARK: - Computed Properties
    var scrollProgress: CGFloat {
        min(max(scrollOffset / 300, 0), 1)
    }

    var angleForScroll: Angle {
        .degrees(90 * scrollProgress)
    }
    
//    var offsetXForScroll: CGFloat {
//        // 왼쪽에서 61pt 떨어진 위치에 중심이 오도록
//        -UIScreen.main.bounds.width / 2 + 61 + holeSize.width / 2
//    }
    
    var offsetYForScroll: CGFloat {
        -50 * scrollProgress
    }

    var interpolatedColor: Color {
        Color.interpolateHex(from: "#0038FF", to: "#C4D1FF", fraction: scrollProgress)
    }

    var filteredItems: [BrandItem] {
        switch selectedCategory {
        case .all:
            return items
        case .top:
            return items.filter { $0.category == .top }
        case .bottom:
            return items.filter { $0.category == .bottom }
        case .accessory:
            return items.filter { $0.category == .accessory }
        }
    }

    // MARK: - Functions
    func updateScrollOffset(_ offset: CGFloat) {
        scrollOffset = min(offset, 300)
    }

    func logoPosition(geo: GeometryProxy) -> CGPoint {
        let centerX = geo.size.width / 2 - 70
        let centerY = geo.size.height / 2 + offsetYForScroll - 30

        let rectLeft = centerX - holeSize.width / 2
        let rectTop = centerY - holeSize.height / 2
        let rectBottom = rectTop + holeSize.height

        let logoX = rectLeft
        let logoY = rectBottom - holeSize.height * 0.25

        return CGPoint(x: logoX, y: logoY + min(scrollOffset, 100))
    }
}
