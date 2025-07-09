import Foundation

struct Product: Hashable, Codable{
    let productId: Int
    let productName: String
    let productImageName: String
    let productCategory: String
    let price: Int
}


