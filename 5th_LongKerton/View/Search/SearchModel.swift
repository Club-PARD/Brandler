import Foundation

struct SearchProduct: Codable, Identifiable {
    let brandId: Int
    let productName: String
    let productImage: String
    let price: Int
    var id: Int { brandId }
}

struct SearchBrand: Codable, Identifiable {
    let brandId: Int
    let brandName: String
    let brandLogo: String
    let brandBanner: String
    let slogan: String
    var id: Int { brandId }
}
