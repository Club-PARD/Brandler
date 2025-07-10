//import Foundation
//
//// MARK: - SearchBrand 모델 및 목데이터
//struct SearchBrand: Identifiable, Hashable, Codable {
//    var id = UUID()
//    let name: String
//    let brandGenre: String
//    let description: String
//    let brandBannerUrl: String
//    let brandLogoUrl: String
//    var isScraped: Bool = true
//    let brandHomePageUrl: String
//    let brandLevel: Int
//}
//
//extension SearchBrand {
//    static let sampleData: [SearchBrand] = [
//        SearchBrand(name: "NukeStreet", brandGenre: "스트릿", description: "강렬한 컬러로 존재감을 드러내는 브랜드입니다.", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/nukestreet", brandLevel: 1),
//        SearchBrand(name: "NukeFormal", brandGenre: "스트릿", description: "강렬한 컬러로 존재감을 드러내는 브랜드입니다.", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/nukestreet", brandLevel: 1),
//        SearchBrand(name: "NukePunk", brandGenre: "스트릿", description: "강렬한 컬러로 존재감을 드러내는 브랜드입니다.", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/nukestreet", brandLevel: 1),
//        SearchBrand(name: "VoidNest", brandGenre: "테크", description: "혁신적인 테크웨어 브랜드입니다.", brandBannerUrl: "mockBanner2", brandLogoUrl: "mockLogo2", brandHomePageUrl: "https://example.com/voidnest", brandLevel: 2),
//        SearchBrand(name: "GreySyntax", brandGenre: "포멀", description: "모던하고 세련된 포멀웨어 브랜드입니다.", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo2", brandHomePageUrl: "https://example.com/greysyntax", brandLevel: 3),
//        SearchBrand(name: "BeatTheory", brandGenre: "스트릿", description: "스트릿 감성의 음악과 패션을 결합한 브랜드입니다.", brandBannerUrl: "mockBanner2", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/beattheory", brandLevel: 1),
//        SearchBrand(name: "RoughLayer", brandGenre: "빈티지", description: "빈티지 스타일을 추구하는 브랜드입니다.", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/roughlayer", brandLevel: 1)
//    ]
//}
//
//// MARK: - SearchBrandCategory & SearchProduct 모델 및 목데이터
//enum SearchBrandCategory: String, CaseIterable, Identifiable {
//    case all = "전체"
//    case top = "상의"
//    case bottom = "하의"
//    case accessory = "악세사리"
//    
//    var id: String { rawValue }
//}
//
//struct SearchProduct: Identifiable {
//    let id = UUID()
//    let productImageUrl: String
//    let name: String
//    let price: Int
//    let productCategory: SearchBrandCategory
//}
//
//extension SearchProduct {
//    static let brandItems: [SearchProduct] = [
//        SearchProduct(productImageUrl: "item1_1", name: "오버사이즈 후디", price: 59000, productCategory: .top),
//        SearchProduct(productImageUrl: "item1_1", name: "오버사이즈 집업", price: 59000, productCategory: .top),
//        SearchProduct(productImageUrl: "item1_1", name: "오버사이즈 티셔츠", price: 59000, productCategory: .top),
//        SearchProduct(productImageUrl: "item1_1", name: "오버사이즈 바지", price: 59000, productCategory: .bottom),
//        SearchProduct(productImageUrl: "item1_1", name: "테크 조거 팬츠", price: 72000, productCategory: .bottom),
//        SearchProduct(productImageUrl: "item1_1", name: "스트릿 버킷햇", price: 34000, productCategory: .accessory),
//        SearchProduct(productImageUrl: "item1_1", name: "빈티지 자켓", price: 98000, productCategory: .top),
//        SearchProduct(productImageUrl: "item1_1", name: "로우 웨이스트 진", price: 88000, productCategory: .bottom),
//        SearchProduct(productImageUrl: "item1_1", name: "레더 크로스백", price: 65000, productCategory: .accessory)
//    ]
//}
