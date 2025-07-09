import Foundation

/// 위젯 또는 앱에서 사용할 브랜드 추천 모델입니다.
struct BrandRecommendation: Identifiable, Codable {
    let id: Int                      // 고유 식별자
    let brandName: String            // 브랜드 이름
    let brandLogoImageName: String  // 브랜드 로고 이미지 이름 (ex. "mockLogo1")
    let bannerImageName: String      // 배너 이미지 이름 (ex. "mockBanner1")
    let description: String          // 간단한 설명
}

extension BrandRecommendation {
    static let sampleData: [BrandRecommendation] = [
        BrandRecommendation(
            id: 1,
            brandName: "무신사 스탠다드",
            brandLogoImageName: "mockLogo1",
            bannerImageName: "mockBanner1",
            description: "미니멀 무드의 일상복 추천!"
        ),
        BrandRecommendation(
            id: 2,
            brandName: "앤더슨벨",
            brandLogoImageName: "mockLogo2",
            bannerImageName: "mockBanner2",
            description: "감성적인 스트릿 룩을 연출해보세요."
        ),
        BrandRecommendation(
            id: 3,
            brandName: "커버낫",
            brandLogoImageName: "mockLogo1",
            bannerImageName: "mockBanner2",
            description: "편안함과 스타일을 동시에!"
        ),
        BrandRecommendation(
            id: 4,
            brandName: "마르디 메크르디",
            brandLogoImageName: "mockLogo2",
            bannerImageName: "mockBanner1",
            description: "화사한 컬러의 캐주얼 브랜드"
        ),
        BrandRecommendation(
            id: 5,
            brandName: "디스이즈네버댓",
            brandLogoImageName: "mockLogo1",
            bannerImageName: "mockBanner2",
            description: "하이엔드 스트릿 무드로 완성된 룩"
        )
    ]
    
    /// 단일 샘플 항목
    static let sample = sampleData.first!
}
