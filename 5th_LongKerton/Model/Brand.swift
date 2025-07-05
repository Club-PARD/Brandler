import Foundation

struct Brand: Identifiable, Hashable {
    var id = UUID()
    let name: String
    let brandGenre: String
    let description: String
    let brandBannerUrl: String
    let brandLogoUrl: String
    var isScraped: Bool = true // 기본값 true로 시작 (디깅됨)
    let brandHomePageUrl: String
    let brandLevel: Int
    
    init(
        id: UUID = UUID(),  // 기본값 지정
        name: String,
        brandGenre: String,
        description: String,
        brandBannerUrl: String,
        brandLogoUrl: String,
        brandHomePageUrl: String,
        brandLevel: Int
        
    ) {
        self.id = id
        self.name = name
        self.brandGenre = brandGenre
        self.description = description
        self.brandBannerUrl = brandBannerUrl
        self.brandLogoUrl = brandLogoUrl
        self.brandHomePageUrl = brandHomePageUrl
        self.brandLevel = brandLevel
    }
}

extension Brand {
    static let sampleData: [Brand] = [
        Brand(id: UUID(), name: "NukeStreet", brandGenre: "스트릿", description: "강렬한 컬러로 존재감을 드러내는 브랜드", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/nukestreet", brandLevel: 1),
        Brand(id: UUID(), name: "VoidNest", brandGenre: "테크", description: "공허 속 기능미를 담은 감성적 아우터", brandBannerUrl: "mockBanner2", brandLogoUrl: "mockLogo2", brandHomePageUrl: "https://example.com/voidnest", brandLevel: 2),
        Brand(id: UUID(), name: "GreySyntax", brandGenre: "포멀", description: "간결한 실루엣 속에서 묵직한 분위기를 표현", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo2", brandHomePageUrl: "https://example.com/greysyntax", brandLevel: 3),
        Brand(id: UUID(), name: "BeatTheory", brandGenre: "스트릿", description: "비트처럼 살아있는 스트릿 무드", brandBannerUrl: "mockBanner2", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/beattheory", brandLevel: 1),
        Brand(id: UUID(), name: "RoughLayer", brandGenre: "빈티지", description: "낡았지만 멋스러운 무드로 과거를 되살리다", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/roughlayer", brandLevel: 1),
        Brand(id: UUID(), name: "CoreClub", brandGenre: "기타", description: "일상 속 편안한 감성과 실용성의 조화", brandBannerUrl: "mockBanner2", brandLogoUrl: "mockLogo2", brandHomePageUrl: "https://example.com/coreclub", brandLevel: 2),
        Brand(id: UUID(), name: "NeonEcho", brandGenre: "기타", description: "빛나는 밤을 위한 미래적인 감성", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo2", brandHomePageUrl: "https://example.com/neonecho", brandLevel: 1),
        Brand(id: UUID(), name: "DustedSoul", brandGenre: "빈티지", description: "먼지 낀 듯한 무드 속 깊은 감성", brandBannerUrl: "mockBanner2", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/dustedsoul", brandLevel: 3),
        Brand(id: UUID(), name: "UrbanDrift", brandGenre: "아메카지", description: "도시를 유영하는 모던한 아웃핏", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo2", brandHomePageUrl: "https://example.com/urbandrift", brandLevel: 2),
        Brand(id: UUID(), name: "FlatForm", brandGenre: "포멀", description: "미니멀리즘의 극단을 추구한 실루엣", brandBannerUrl: "mockBanner2", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/flatform", brandLevel: 1),
        Brand(id: UUID(), name: "WornIn", brandGenre: "빈티지", description: "레트로 감성을 현대적으로 재해석한 브랜드", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo2", brandHomePageUrl: "https://example.com/wornin", brandLevel: 2),
        Brand(id: UUID(), name: "EdgeCraft", brandGenre: "테크", description: "기능성과 조형미의 완벽한 밸런스", brandBannerUrl: "mockBanner2", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/edgecraft", brandLevel: 3),
        Brand(id: UUID(), name: "SlowBurn", brandGenre: "포멀", description: "잔잔하게 타오르는 데일리 무드", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo2", brandHomePageUrl: "https://example.com/slowburn", brandLevel: 1),
        Brand(id: UUID(), name: "FormFreak", brandGenre: "페미닌", description: "형태를 해체한 실험적 디자인", brandBannerUrl: "mockBanner2", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/formfreak", brandLevel: 2),
        Brand(id: UUID(), name: "HighNote", brandGenre: "스트릿", description: "힙합에서 영감을 받은 자유로운 실루엣", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/highnote", brandLevel: 1),
        Brand(id: UUID(), name: "MonoTone", brandGenre: "포멀", description: "톤온톤의 절제된 감성", brandBannerUrl: "mockBanner2", brandLogoUrl: "mockLogo2", brandHomePageUrl: "https://example.com/monotone", brandLevel: 2),
        Brand(id: UUID(), name: "DazedClub", brandGenre: "펑크", description: "황홀한 클럽 나잇을 위한 유니크 룩", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo2", brandHomePageUrl: "https://example.com/dazedclub", brandLevel: 1),
        Brand(id: UUID(), name: "BrickHaus", brandGenre: "아메카지", description: "거칠지만 세련된 도시적 무드", brandBannerUrl: "mockBanner2", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/brickhaus", brandLevel: 2),
        Brand(id: UUID(), name: "ArtCore", brandGenre: "히피", description: "아트워크 기반의 창의적 감성", brandBannerUrl: "mockBanner1", brandLogoUrl: "mockLogo2", brandHomePageUrl: "https://example.com/artcore", brandLevel: 3),
        Brand(id: UUID(), name: "EchoCraft", brandGenre: "스트릿", description: "새로운 시대의 복고풍 믹스", brandBannerUrl: "mockBanner2", brandLogoUrl: "mockLogo1", brandHomePageUrl: "https://example.com/echocraft", brandLevel: 1)
    ]
}
