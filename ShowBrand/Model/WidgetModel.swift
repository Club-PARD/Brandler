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
}
