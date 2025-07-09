//
//  BrandCard.swift
//  5th_LongKerton
//
//  Created by Kim Kyengdong on 7/9/25.
//

import Foundation

struct BrandCard: Hashable, Codable{
    var brandId : Int
    let brandName: String
    let brandLogo: String
    let brandBanner: String
    let slogan : String
}
