import Foundation // Foundation 프레임워크를 가져옵니다. 기본적인 데이터 타입과 UUID 등을 제공합니다.

/// `Product` 구조체는 앱 내에서 개별 상품의 상세 정보를 나타내는 데이터 모델입니다.
///
/// - `Identifiable`: SwiftUI의 `ForEach` 뷰와 함께 사용하여 상품 목록을 효율적으로 렌더링하고 관리할 수 있도록 합니다.
///   각 상품이 고유한 `id`를 가짐으로써, SwiftUI가 변경사항을 추적하고 UI를 최적화할 수 있습니다.
struct Product: Identifiable {
    // MARK: - Properties

    // `id`: 각 `Product` 인스턴스의 고유 식별자입니다.
    // `UUID()` 기본값을 사용하여 인스턴스 생성 시 자동으로 고유한 ID가 할당됩니다.
    let id = UUID()
    
    // `productImageUrl`: 상품 이미지의 파일 이름 또는 URL입니다.
    // 앱의 Assets.xcassets에 있는 이미지 이름이거나, 웹에서 로드할 이미지의 URL이 될 수 있습니다.
    let productImageUrl: String
    
    // `name`: 상품의 이름입니다 (예: "오버사이즈 후디").
    let name: String
    
    // `price`: 상품의 가격입니다 (정수형).
    let price: Int
    
    // `productCategory`: 상품이 속하는 카테고리입니다.
    // `BrandCategory` enum을 사용하여 미리 정의된 카테고리 중 하나를 가집니다.
    let productCategory: BrandCategory
    
    // `brandId`: (주석 처리됨) 상품이 속한 브랜드의 ID를 나타내는 속성입니다.
    // 현재는 사용되지 않지만, 향후 특정 브랜드의 상품을 필터링하거나 연결할 때 유용할 수 있습니다.
    // let brandId: Int
}

/// `BrandCategory` 열거형은 상품이 분류될 수 있는 카테고리들을 정의합니다.
///
/// - `String`: 각 케이스가 원시 값(Raw Value)으로 문자열을 가질 수 있도록 합니다.
///   이는 사용자에게 표시될 카테고리 이름으로 직접 사용될 수 있습니다.
/// - `CaseIterable`: 모든 케이스를 컬렉션(`allCases`)으로 제공하여 `ForEach` 루프 등에서 쉽게 순회할 수 있도록 합니다.
/// - `Identifiable`: SwiftUI의 `ForEach` 등에서 고유한 식별자로 사용될 수 있도록 합니다.
///   이를 통해 카테고리 목록을 효율적으로 관리하고 UI를 업데이트할 수 있습니다.
enum BrandCategory: String, CaseIterable, Identifiable {
    // MARK: - Cases

    // `all`: 모든 상품을 포함하는 기본 카테고리. RawValue는 "전체".
    case all = "전체"
    // `top`: 상의 카테고리. RawValue는 "상의".
    case top = "상의"
    
    case bottom = "하의"
    
    // `accessory`: 액세서리 카테고리. RawValue는 "악세사리".
    case accessory = "악세사리"

    // MARK: - Identifiable Conformance

    /// `Identifiable` 프로토콜 요구사항을 충족하기 위한 `id` 계산 속성입니다.
    /// 각 카테고리의 `rawValue` (String)를 고유 식별자로 사용합니다.
    var id: String { self.rawValue }
}

/// `Product` 구조체의 확장을 통해 미리 정의된 샘플 상품 데이터를 제공합니다.
///
/// 이 샘플 데이터는 개발 및 테스트 목적으로 사용되며, UI 프로토타이핑, 기능 테스트,
/// 그리고 SwiftUI 캔버스 미리보기에서 실제와 유사한 데이터를 표시하는 데 유용합니다.
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
