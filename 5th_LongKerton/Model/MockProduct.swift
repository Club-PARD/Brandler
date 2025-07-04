
import SwiftUI

struct Product: Identifiable {
    let id = UUID()
    let imageName: String
    let name: String
    let category: String // 예: 상의, 하의, 신발 등
}

extension Product {
    static let sampleProducts: [Product] = [
        Product(imageName: "product_shirt", name: "오버핏 셔츠", category: "상의"),
        Product(imageName: "product_pants", name: "와이드 팬츠", category: "하의"),
        Product(imageName: "product_sneakers", name: "런닝 스니커즈", category: "신발")
    ]
}
