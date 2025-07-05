// product model 정태주

import Foundation

struct Product: Identifiable {
    let productId = Int
    let productName: String
    let productImageUrl: String
    let productCategory: String
    let price: Int
    let brand: Brand
    
}

//enum BrandCategory: String, CaseIterable, Identifiable {
//    case all = "전체"
//    case top = "상의"
//    case bottom = "하의"
//    case accessory = "악세사리"
//
//    var id: String { self.rawValue }
//}
