import Foundation // Foundation 프레임워크를 가져옵니다. 기본적인 데이터 타입과 컬렉션 등을 제공합니다.
/// `Brand` 구조체는 패션 브랜드의 상세 정보를 나타내는 데이터 모델입니다.
///
/// - `Identifiable`: SwiftUI의 `ForEach` 등에서 고유한 식별자로 사용될 수 있도록 합니다.
///   이를 통해 리스트나 그리드에서 아이템을 효율적으로 업데이트하고 관리할 수 있습니다.
/// - `Hashable`: 집합(Set)이나 딕셔너리(Dictionary)의 키 등으로 사용될 수 있도록 합니다.
///   특히, 중복 방지나 빠른 검색에 유용합니다.
/// - `Codable`: JSON과 같은 외부 데이터 형식으로 인코딩(Codable) 및 디코딩(Decodable)될 수 있도록 합니다.
///   이는 네트워크 통신이나 로컬 저장소에서 데이터를 쉽게 주고받는 데 필수적입니다.

struct BrandInfo: Hashable, Codable {
      let id: Int
      let brandName: String
      let brandLogo: String
      let brandBanner: String
      let description: String
      let brandPageUrl: String
      let genre: String
}

struct Brand: Identifiable, Hashable, Codable {
        let id: Int
        let name: String
        let brandGenre: String
        let description: String
        let brandBannerUrl: String
        let brandLogoUrl: String
        var isScraped: Bool = false // 기본값 false
        let brandHomePageUrl: String
        let brandLevel: Int

    init(
            id: Int,
            name: String,
            brandGenre: String,
            description: String,
            brandBannerUrl: String,
            brandLogoUrl: String,
            brandHomePageUrl: String,
            brandLevel: Int,
            isScraped: Bool = false // 기본값 false
        ) {
            self.id = id
            self.name = name
            self.brandGenre = brandGenre
            self.description = description
            self.brandBannerUrl = brandBannerUrl
            self.brandLogoUrl = brandLogoUrl
            self.brandHomePageUrl = brandHomePageUrl
            self.brandLevel = brandLevel
            self.isScraped = isScraped
        }
}


extension Brand {
    static let sampleData: [Brand] = [

        Brand(id: 1, name: "NukeStreet", brandGenre: "스트릿", description: "강렬한 컬러로 존재감을 드러내는 브랜드는, 단순한 색의 선택을 넘어 브랜드의 정체성과 감성을 강하게 전달하는 전략을 추구합니다. 선명하고 대담한 컬러 팔레트는 단번에 시선을 사로잡으며, 브랜드가 가진 개성과 독창성을 강조합니다. 이는 브랜드가 경쟁이 치열한 시장 속에서도 뚜렷한 인상을 남기고, 소비자들의 기억에 오랫동안 남을 수 있도록 도와줍니다.", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/nukestreet", brandLevel: 1),
        Brand(id: 2, name: "VoidNest", brandGenre: "테크", description: "공허 속 기능미를 담은 감성적 아우터", brandBannerUrl: "mockBanner2", brandLogoUrl: "mockLogo2", brandHomePageUrl: "https://example.com/voidnest", brandLevel: 2),
        Brand(id: 3, name: "GreySyntax", brandGenre: "포멀", description: "간결한 실루엣 속에서 묵직한 분위기를 표현", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo2", brandHomePageUrl: "https://example.com/greysyntax", brandLevel: 3),
        Brand(id: 4, name: "BeatTheory", brandGenre: "스트릿", description: "비트처럼 살아있는 스트릿 무드", brandBannerUrl: "mockBanner2", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/beattheory", brandLevel: 1),
        Brand(id: 5, name: "RoughLayer", brandGenre: "빈티지", description: "낡았지만 멋스러운 무드로 과거를 되살리다", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/roughlayer", brandLevel: 1),
        Brand(id: 6, name: "CoreClub", brandGenre: "기타", description: "일상 속 편안한 감성과 실용성의 조화", brandBannerUrl: "mockBanner2", brandLogoUrl: "mockLogo2", brandHomePageUrl: "https://example.com/coreclub", brandLevel: 2),
        Brand(id: 7, name: "NeonEcho", brandGenre: "기타", description: "빛나는 밤을 위한 미래적인 감성", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo2", brandHomePageUrl: "https://example.com/neonecho", brandLevel: 1),
        Brand(id: 8, name: "DustedSoul", brandGenre: "빈티지", description: "먼지 낀 듯한 무드 속 깊은 감성", brandBannerUrl: "mockBanner2", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/dustedsoul", brandLevel: 3),
        Brand(id: 9, name: "UrbanDrift", brandGenre: "아메카지", description: "도시를 유영하는 모던한 아웃핏", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo2", brandHomePageUrl: "https://example.com/urbandrift", brandLevel: 2),
        Brand(id: 10, name: "FlatForm", brandGenre: "포멀", description: "미니멀리즘의 극단을 추구한 실루엣", brandBannerUrl: "mockBanner2", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/flatform", brandLevel: 1),
        Brand(id: 11, name: "WornIn", brandGenre: "빈티지", description: "레트로 감성을 현대적으로 재해석한 브랜드", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo2", brandHomePageUrl: "https://example.com/wornin", brandLevel: 2),
        Brand(id: 12, name: "EdgeCraft", brandGenre: "테크", description: "기능성과 조형미의 완벽한 밸런스", brandBannerUrl: "mockBanner2", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/edgecraft", brandLevel: 3),
        Brand(id: 13, name: "SlowBurn", brandGenre: "포멀", description: "잔잔하게 타오르는 데일리 무드", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo2", brandHomePageUrl: "https://example.com/slowburn", brandLevel: 1),
        Brand(id: 14, name: "FormFreak", brandGenre: "페미닌", description: "형태를 해체한 실험적 디자인", brandBannerUrl: "mockBanner2", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/formfreak", brandLevel: 2),
        Brand(id: 15, name: "HighNote", brandGenre: "스트릿", description: "힙합에서 영감을 받은 자유로운 실루엣", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/highnote", brandLevel: 1),
        Brand(id: 16, name: "MonoTone", brandGenre: "포멀", description: "톤온톤의 절제된 감성", brandBannerUrl: "mockBanner2", brandLogoUrl: "mockLogo2", brandHomePageUrl: "https://example.com/monotone", brandLevel: 2),
        Brand(id: 17, name: "DazedClub", brandGenre: "펑크", description: "황홀한 클럽 나잇을 위한 유니크 룩", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo2", brandHomePageUrl: "https://example.com/dazedclub", brandLevel: 1),
        Brand(id: 18, name: "BrickHaus", brandGenre: "아메카지", description: "거칠지만 세련된 도시적 무드", brandBannerUrl: "mockBanner2", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/brickhaus", brandLevel: 2),
        Brand(id: 19, name: "ArtCore", brandGenre: "히피", description: "아트워크 기반의 창의적 감성", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo2", brandHomePageUrl: "https://example.com/artcore", brandLevel: 3),
        Brand(id: 20, name: "EchoCraft", brandGenre: "스트릿", description: "새로운 시대의 복고풍 믹스", brandBannerUrl: "mockBanner2", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/echocraft", brandLevel: 1)

    ]
}

//    // MARK: - Properties
//
//    // `id`: 각 `Brand` 인스턴스의 고유 식별자입니다.
//    // `UUID()` 기본값을 사용하여 인스턴스 생성 시 자동으로 고유한 ID가 할당됩니다.
//    var id = UUID()
//
//    // `name`: 브랜드의 이름 (예: "NukeStreet").
//    let name: String
//
//    // `brandGenre`: 브랜드의 장르 또는 스타일 (예: "스트릿", "포멀").
//    let brandGenre: String
//
//    // `description`: 브랜드에 대한 상세 설명입니다.
//    let description: String
//
//    // `brandBannerUrl`: 브랜드 배너 이미지의 파일 이름 또는 URL입니다.
//    // 실제 앱에서는 Assets.xcassets의 이미지 이름이나 웹 이미지 URL이 될 수 있습니다.
//    let brandBannerUrl: String
//
//    // `brandLogoUrl`: 브랜드 로고 이미지의 파일 이름 또는 URL입니다.
//    let brandLogoUrl: String
//
//    // `isScraped`: 브랜드가 스크랩(찜)되었는지 여부를 나타내는 Bool 값입니다.
//    // 기본값은 `true`로 설정되어 있습니다 (초기에는 "디깅된" 상태로 시작).
//    var isScraped: Bool = true
//
//    // `brandHomePageUrl`: 브랜드 공식 웹사이트의 URL입니다.
//    let brandHomePageUrl: String
//
//    // `brandLevel`: 브랜드의 레벨 또는 등급을 나타내는 정수 값입니다.
//    // 이는 UI에서 다른 배지나 아이콘을 표시하는 데 사용될 수 있습니다.
//    let brandLevel: Int

// MARK: - Initialization

/// `Brand` 구조체의 초기화 메서드입니다.
///
/// - Parameters:
///   - id: 브랜드의 고유 ID. 기본값은 새로운 `UUID()`입니다.
///   - name: 브랜드 이름.
///   - brandGenre: 브랜드 장르.
///   - description: 브랜드 설명.
///   - brandBannerUrl: 배너 이미지 URL 또는 이름.
///   - brandLogoUrl: 로고 이미지 URL 또는 이름.
///   - brandHomePageUrl: 브랜드 홈페이지 URL.
///   - brandLevel: 브랜드 레벨.
//    init(
//        id: UUID = UUID(), // 기본값 지정
//        name: String,
//        brandGenre: String,
//        description: String,
//        brandBannerUrl: String,
//        brandLogoUrl: String,
//        brandHomePageUrl: String,
//        brandLevel: Int
//    ) {
//        self.id = id
//        self.name = name
//        self.brandGenre = brandGenre
//        self.description = description
//        self.brandBannerUrl = brandBannerUrl
//        self.brandLogoUrl = brandLogoUrl
//        self.brandHomePageUrl = brandHomePageUrl
//        self.brandLevel = brandLevel
//        // `isScraped`는 초기화 시 기본값 `true`를 사용합니다.
