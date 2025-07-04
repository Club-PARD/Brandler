//
//  BrandItem.swift
//  BrandPage
//
//  Created by 정태주 on 7/2/25.
//

// BrandItem.swift
import Foundation

struct BrandItem: Identifiable {
    let id = UUID()
    let frontImageName: String
    let name: String
    let price: Int
    let category: BrandCategory
}

enum BrandCategory: String, CaseIterable, Identifiable {
    case all = "전체"
    case top = "상의"
    case bottom = "하의"
    case accessory = "악세사리"

    var id: String { self.rawValue }
}
