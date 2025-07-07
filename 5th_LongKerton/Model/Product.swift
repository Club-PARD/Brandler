import Foundation

struct Product: Identifiable {
    let id = UUID()
    let productImageUrl: String
    let name: String
    let price: Int
    let productCategory: BrandCategory
//    let brandId: Int
}

enum BrandCategory: String, CaseIterable, Identifiable {
    case all = "전체"
    case top = "상의"
    case bottom = "하의"
    case accessory = "악세사리"

    var id: String { self.rawValue }
}

extension Product {
    static let brandItems: [Product] = [
        Product(productImageUrl: "level1 1", name: "오버사이즈 후디", price: 59000, productCategory: .top),
        Product(productImageUrl: "level1 1", name: "테크 조거 팬츠", price: 72000, productCategory: .bottom),
        Product(productImageUrl: "level1 1", name: "스트릿 버킷햇", price: 34000, productCategory: .accessory),
        Product(productImageUrl: "level1 1", name: "빈티지 자켓", price: 98000, productCategory: .top),
        Product(productImageUrl: "level1 1", name: "로우 웨이스트 진", price: 88000, productCategory: .bottom),
        Product(productImageUrl: "level1 1", name: "레더 크로스백", price: 65000, productCategory: .accessory),
        Product(productImageUrl: "level1 1", name: "미니멀 셔츠", price: 56000, productCategory: .top),
        Product(productImageUrl: "level1 1", name: "카고 팬츠", price: 74000, productCategory: .bottom),
        Product(productImageUrl: "level1 1", name: "골드 이어커프", price: 22000, productCategory: .accessory),
        Product(productImageUrl: "level1 1", name: "크롭드 스웻셔츠", price: 47000, productCategory: .top),
        Product(productImageUrl: "level1 1", name: "테이퍼드 팬츠", price: 68000, productCategory: .bottom),
        Product(productImageUrl: "level1 1", name: "페이즐리 스카프", price: 19000, productCategory: .accessory),
        Product(productImageUrl: "level1 1", name: "디스트로이드 니트", price: 62000, productCategory: .top),
        Product(productImageUrl: "level1 1", name: "플리츠 미니스커트", price: 57000, productCategory: .bottom),
        Product(productImageUrl: "level1 1", name: "빈티지 백팩", price: 59000, productCategory: .accessory),
        Product(productImageUrl: "level1 1", name: "루즈핏 티셔츠", price: 39000, productCategory: .top),
        Product(productImageUrl: "level1 1", name: "하이라이즈 데님", price: 71000, productCategory: .bottom),
        Product(productImageUrl: "level1 1", name: "실버 체인 팔찌", price: 27000, productCategory: .accessory),
        Product(productImageUrl: "level1 1", name: "테크 베스트", price: 87000, productCategory: .top),
        Product(productImageUrl: "level1 1", name: "조거 스웻팬츠", price: 64000, productCategory: .bottom)
    ]
}
