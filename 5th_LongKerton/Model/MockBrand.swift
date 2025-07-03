//
//  DataStruct.swift
//  5th_LongKerton
//
//  Created by Kim Kyengdong on 6/22/25.
//



import Foundation

struct MockBrand: Identifiable, Hashable {
    var id = UUID()
    let name: String
    let genre: String
    let description: String
    let bannerImageName: String
    let logoImageName: String
    var isScraped: Bool = true // 기본값 true로 시작 (디깅됨)
    
    init(
           id: UUID = UUID(),  // 기본값 지정
           name: String,
           genre: String,
           description: String,
           bannerImageName: String,
           logoImageName: String
       ) {
           self.id = id
           self.name = name
           self.genre = genre
           self.description = description
           self.bannerImageName = bannerImageName
           self.logoImageName = logoImageName
       }
}

extension MockBrand {
    static let sampleData: [MockBrand] = [
        MockBrand(id: UUID(), name: "NukeStreet", genre: "Streetwear", description: "강렬한 컬러로 존재감을 드러내는 브랜드", bannerImageName: "mockBanner1", logoImageName: "mockLogo1"),
        MockBrand(id: UUID(), name: "VoidNest", genre: "Techwear", description: "공허 속 기능미를 담은 감성적 아우터", bannerImageName: "mockBanner2", logoImageName: "mockLogo2"),
        MockBrand(id: UUID(), name: "GreySyntax", genre: "Minimal", description: "간결한 실루엣 속에서 묵직한 분위기를 표현", bannerImageName: "mockBanner1", logoImageName: "mockLogo2"),
        MockBrand(id: UUID(), name: "BeatTheory", genre: "Streetwear", description: "비트처럼 살아있는 스트릿 무드", bannerImageName: "mockBanner2", logoImageName: "mockLogo1"),
        MockBrand(id: UUID(), name: "RoughLayer", genre: "Vintage", description: "낡았지만 멋스러운 무드로 과거를 되살리다", bannerImageName: "mockBanner1", logoImageName: "mockLogo1"),
        MockBrand(id: UUID(), name: "CoreClub", genre: "Casual", description: "일상 속 편안한 감성과 실용성의 조화", bannerImageName: "mockBanner2", logoImageName: "mockLogo2"),
        MockBrand(id: UUID(), name: "NeonEcho", genre: "Clubwear", description: "빛나는 밤을 위한 미래적인 감성", bannerImageName: "mockBanner1", logoImageName: "mockLogo2"),
        MockBrand(id: UUID(), name: "DustedSoul", genre: "Vintage", description: "먼지 낀 듯한 무드 속 깊은 감성", bannerImageName: "mockBanner2", logoImageName: "mockLogo1"),
        MockBrand(id: UUID(), name: "UrbanDrift", genre: "Urban", description: "도시를 유영하는 모던한 아웃핏", bannerImageName: "mockBanner1", logoImageName: "mockLogo2"),
        MockBrand(id: UUID(), name: "FlatForm", genre: "Minimal", description: "미니멀리즘의 극단을 추구한 실루엣", bannerImageName: "mockBanner2", logoImageName: "mockLogo1"),
        MockBrand(id: UUID(), name: "WornIn", genre: "Retro", description: "레트로 감성을 현대적으로 재해석한 브랜드", bannerImageName: "mockBanner1", logoImageName: "mockLogo2"),
        MockBrand(id: UUID(), name: "EdgeCraft", genre: "Techwear", description: "기능성과 조형미의 완벽한 밸런스", bannerImageName: "mockBanner2", logoImageName: "mockLogo1"),
        MockBrand(id: UUID(), name: "SlowBurn", genre: "Casual", description: "잔잔하게 타오르는 데일리 무드", bannerImageName: "mockBanner1", logoImageName: "mockLogo2"),
        MockBrand(id: UUID(), name: "FormFreak", genre: "Avant-garde", description: "형태를 해체한 실험적 디자인", bannerImageName: "mockBanner2", logoImageName: "mockLogo1"),
        MockBrand(id: UUID(), name: "HighNote", genre: "Streetwear", description: "힙합에서 영감을 받은 자유로운 실루엣", bannerImageName: "mockBanner1", logoImageName: "mockLogo1"),
        MockBrand(id: UUID(), name: "MonoTone", genre: "Minimal", description: "톤온톤의 절제된 감성", bannerImageName: "mockBanner2", logoImageName: "mockLogo2"),
        MockBrand(id: UUID(), name: "DazedClub", genre: "Clubwear", description: "황홀한 클럽 나잇을 위한 유니크 룩", bannerImageName: "mockBanner1", logoImageName: "mockLogo2"),
        MockBrand(id: UUID(), name: "BrickHaus", genre: "Urban", description: "거칠지만 세련된 도시적 무드", bannerImageName: "mockBanner2", logoImageName: "mockLogo1"),
        MockBrand(id: UUID(), name: "ArtCore", genre: "Indie", description: "아트워크 기반의 창의적 감성", bannerImageName: "mockBanner1", logoImageName: "mockLogo2"),
        MockBrand(id: UUID(), name: "EchoCraft", genre: "Y2K", description: "새로운 시대의 복고풍 믹스", bannerImageName: "mockBanner2", logoImageName: "mockLogo1"),
        MockBrand(id: UUID(), name: "CrudeTheory", genre: "Retro", description: "미래지향적인 디자인으로 새로운 룩 제안", bannerImageName: "mockBanner1", logoImageName: "mockLogo2"),
            MockBrand(id: UUID(), name: "CrudeVerse", genre: "Casual", description: "실험적인 감성을 감각적으로 해석", bannerImageName: "mockBanner1", logoImageName: "mockLogo1"),
            MockBrand(id: UUID(), name: "ShadowTheory", genre: "Clubwear", description: "데일리웨어로도 손색없는 유니크함", bannerImageName: "mockBanner1", logoImageName: "mockLogo1"),
            MockBrand(id: UUID(), name: "NoiseLab", genre: "Avant-garde", description: "독특한 색감과 소재로 무드를 완성", bannerImageName: "mockBanner2", logoImageName: "mockLogo2"),
            MockBrand(id: UUID(), name: "LiquidSyntax", genre: "Urban", description: "자연스러운 색감으로 조화로운 무드 연출", bannerImageName: "mockBanner1", logoImageName: "mockLogo1"),
            MockBrand(id: UUID(), name: "NeoCore", genre: "Clubwear", description: "실험적인 감성을 감각적으로 해석", bannerImageName: "mockBanner2", logoImageName: "mockLogo1"),
            MockBrand(id: UUID(), name: "NovaTone", genre: "Techwear", description: "감각적인 실루엣으로 개성을 표현한 브랜드", bannerImageName: "mockBanner1", logoImageName: "mockLogo2"),
            MockBrand(id: UUID(), name: "NoiseClub", genre: "Clubwear", description: "과거와 현재를 잇는 감각적인 리메이크", bannerImageName: "mockBanner1", logoImageName: "mockLogo2"),
            MockBrand(id: UUID(), name: "StaticSyntax", genre: "Avant-garde", description: "독특한 색감과 소재로 무드를 완성", bannerImageName: "mockBanner1", logoImageName: "mockLogo1"),
            MockBrand(id: UUID(), name: "LiquidLine", genre: "Urban", description: "기능성과 스타일의 조화", bannerImageName: "mockBanner1", logoImageName: "mockLogo2"),
            MockBrand(id: UUID(), name: "GritStudio", genre: "Streetwear", description: "도시적인 감성과 스트리트 무드의 조화", bannerImageName: "mockBanner2", logoImageName: "mockLogo1"),
            MockBrand(id: UUID(), name: "EchoFade", genre: "Y2K", description: "복고풍 감성에 미래지향적 요소를 믹스", bannerImageName: "mockBanner2", logoImageName: "mockLogo2"),
            MockBrand(id: UUID(), name: "AshFrame", genre: "Minimal", description: "절제된 라인으로 강렬한 인상을 남기는 디자인", bannerImageName: "mockBanner1", logoImageName: "mockLogo1"),
            MockBrand(id: UUID(), name: "SlowLayer", genre: "Casual", description: "느긋한 감성을 입은 데일리룩", bannerImageName: "mockBanner1", logoImageName: "mockLogo2"),
            MockBrand(id: UUID(), name: "GrainTone", genre: "Vintage", description: "입을수록 멋스러워지는 오래된 감성", bannerImageName: "mockBanner2", logoImageName: "mockLogo2"),
            MockBrand(id: UUID(), name: "DuskForm", genre: "Indie", description: "감성적인 색감과 실루엣으로 자신만의 무드 표현", bannerImageName: "mockBanner1", logoImageName: "mockLogo1"),
            MockBrand(id: UUID(), name: "RawEdge", genre: "Streetwear", description: "날 것 그대로의 거칠고 자유로운 감성", bannerImageName: "mockBanner2", logoImageName: "mockLogo2"),
            MockBrand(id: UUID(), name: "SoftCrash", genre: "Techwear", description: "부드러움 속 강인함을 담은 실루엣", bannerImageName: "mockBanner2", logoImageName: "mockLogo1"),
            MockBrand(id: UUID(), name: "VoidLayer", genre: "Minimal", description: "미니멀 속 깊이를 표현한 절제된 디자인", bannerImageName: "mockBanner1", logoImageName: "mockLogo2"),
            MockBrand(id: UUID(), name: "GhostGrid", genre: "Urban", description: "도시 속 유영하는 듯한 자유로운 룩", bannerImageName: "mockBanner1", logoImageName: "mockLogo2"),
            MockBrand(id: UUID(), name: "DenseWave", genre: "Y2K", description: "시선을 사로잡는 컬러풀한 무드", bannerImageName: "mockBanner2", logoImageName: "mockLogo1"),
            MockBrand(id: UUID(), name: "PureCrash", genre: "Clubwear", description: "클럽을 위한 광택과 유니크한 디테일", bannerImageName: "mockBanner2", logoImageName: "mockLogo2"),
            MockBrand(id: UUID(), name: "FutureDust", genre: "Techwear", description: "미래적 요소와 빈티지한 감성의 조화", bannerImageName: "mockBanner1", logoImageName: "mockLogo2"),
            MockBrand(id: UUID(), name: "EdgeDrop", genre: "Streetwear", description: "트렌디한 감성 속 날카로운 개성", bannerImageName: "mockBanner2", logoImageName: "mockLogo1"),
            MockBrand(id: UUID(), name: "MuteSyntax", genre: "Minimal", description: "조용하지만 강렬한 존재감의 디자인", bannerImageName: "mockBanner1", logoImageName: "mockLogo1"),
            MockBrand(id: UUID(), name: "BaseFrame", genre: "Urban", description: "기초에 충실한 도시적인 실루엣", bannerImageName: "mockBanner2", logoImageName: "mockLogo2"),
            MockBrand(id: UUID(), name: "DarkLayer", genre: "Vintage", description: "어두운 무드 속 따뜻함을 담은 룩", bannerImageName: "mockBanner2", logoImageName: "mockLogo1"),
            MockBrand(id: UUID(), name: "OddCraft", genre: "Avant-garde", description: "기괴하지만 매혹적인 형태의 조화", bannerImageName: "mockBanner1", logoImageName: "mockLogo2"),
            MockBrand(id: UUID(), name: "NeoRaw", genre: "Indie", description: "날 것의 감성을 현대적으로 재해석", bannerImageName: "mockBanner2", logoImageName: "mockLogo2"),
            MockBrand(id: UUID(), name: "HighNoise", genre: "Clubwear", description: "소리처럼 시선을 사로잡는 컬러와 실루엣", bannerImageName: "mockBanner1", logoImageName: "mockLogo1"),
            MockBrand(id: UUID(), name: "MuteSyntax+", genre: "Minimal", description: "감정을 절제한 디자인의 미학", bannerImageName: "mockBanner2", logoImageName: "mockLogo2"),
            MockBrand(id: UUID(), name: "ZoneCrash", genre: "Y2K", description: "복고와 현대의 경계를 넘나드는 컬렉션", bannerImageName: "mockBanner1", logoImageName: "mockLogo2"),
            MockBrand(id: UUID(), name: "HardFlick", genre: "Streetwear", description: "거친 듯 부드러운 스트릿 무드", bannerImageName: "mockBanner2", logoImageName: "mockLogo1"),
            MockBrand(id: UUID(), name: "SoftNoise", genre: "Indie", description: "속삭이듯 강렬한 존재감을 가진 의상", bannerImageName: "mockBanner1", logoImageName: "mockLogo2"),
            MockBrand(id: UUID(), name: "ShellCore", genre: "Techwear", description: "기능성에 기반한 미니멀 테크 감성", bannerImageName: "mockBanner2", logoImageName: "mockLogo1"),
            MockBrand(id: UUID(), name: "WovenSyntax", genre: "Casual", description: "편안하지만 감각적인 직조감 표현", bannerImageName: "mockBanner2", logoImageName: "mockLogo2"),
            MockBrand(id: UUID(), name: "DripVoid", genre: "Avant-garde", description: "형태와 색을 해체하고 다시 조립한 무드", bannerImageName: "mockBanner1", logoImageName: "mockLogo1"),
            MockBrand(id: UUID(), name: "DreamCrate", genre: "Vintage", description: "꿈결 같은 색감으로 완성된 레트로 룩", bannerImageName: "mockBanner2", logoImageName: "mockLogo2"),
            MockBrand(id: UUID(), name: "NightEdge", genre: "Urban", description: "밤을 닮은 차분하면서도 세련된 실루엣", bannerImageName: "mockBanner1", logoImageName: "mockLogo1"),
            MockBrand(id: UUID(), name: "HushCore", genre: "Minimal", description: "극도로 정제된 조용한 아름다움", bannerImageName: "mockBanner1", logoImageName: "mockLogo2")
    ]
}
