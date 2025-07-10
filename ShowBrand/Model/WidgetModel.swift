import Foundation

struct BrandRecommendation: Codable, Identifiable {
    let id: Int
    let brandName: String
    let brandLogoImageName: String
    let bannerImageName: String

    let genre: String?
    let slogan: String?

    enum CodingKeys: String, CodingKey {
        case id = "brandId"
        case brandName = "brandName"
        case brandLogoImageName = "brandLogo"
        case bannerImageName = "brandBanner"
        case genre
        case slogan
    }

//    static var placeholder: BrandRecommendation {
//        .init(
//            id: 0,
//            brandName: "플레이스홀더 브랜드",
//            brandLogoImageName: "placeholder_logo",
//            bannerImageName: "placeholder_banner",
//            genre: "캐주얼",
//            slogan: "플레이스홀더 문구입니다"
//        )
//    }
}
