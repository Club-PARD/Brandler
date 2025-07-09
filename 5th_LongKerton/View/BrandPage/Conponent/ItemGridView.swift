import SwiftUI // SwiftUI 프레임워크를 가져옵니다. UI를 선언적으로 구축하는 데 필요합니다.

/// `ItemGridView`는 제품 아이템들을 그리드 형태로 표시하는 뷰입니다.
/// 필터링된 아이템 목록을 `BrandViewModel`에서 가져와 표시하며,
/// 아이템이 없을 경우 대체 메시지를 보여줍니다.
/// 각 아이템은 뒤집기 애니메이션을 포함하는 `FlipCardItemView`로 표시됩니다.
struct ItemGridView: View {
    // `@EnvironmentObject`를 사용하여 `BrandViewModel`을 환경에서 주입받습니다.
    // 이는 뷰모델이 앱의 여러 뷰에서 공유되는 상태를 관리할 때 유용합니다.
    @EnvironmentObject var viewModel: BrandViewModel
    
    // `@State` 프로퍼티 래퍼를 사용하여 현재 뒤집힌 카드의 고유 ID를 관리합니다.
    // `UUID?` 타입으로, 어떤 카드도 뒤집히지 않았을 때는 `nil`이 됩니다.
    @State private var flippedID: Int? = nil
    let items : [Product]
    // `LazyVGrid`에 사용할 열(column) 레이아웃을 정의합니다.
    // `.flexible()`은 각 열이 사용 가능한 공간을 유연하게 나누어 갖도록 합니다.
    // 여기서는 3개의 유연한 열을 정의하여 아이템이 3개씩 가로로 배치되도록 합니다.
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // MARK: - Body

    var body: some View {
        // 뷰모델의 `filteredItems` 배열이 비어있는지 확인합니다.
        if items.isEmpty {
            // 아이템이 없을 경우 표시할 대체 콘텐츠입니다.
            VStack(spacing: 12) { // 수직으로 요소를 정렬하고 12pt 간격을 둡니다.
                // 상단에 150pt의 공간을 추가하여 텍스트를 중앙에 가깝게 배치합니다.
                Spacer().frame(height: 150)
                    
                // "아직 비어있습니다" 메시지를 표시합니다.
                Text("아직 비어있습니다")
                    // "Pretendard-Bold" 폰트와 14pt 크기를 적용합니다.
                    .font(.custom("Pretendard-Bold", size: 14))
                    .foregroundColor(.gray) // 텍스트 색상을 회색으로 설정합니다.
                    .multilineTextAlignment(.center) // 여러 줄 텍스트를 중앙 정렬합니다.
                    
                // 하단에도 150pt의 공간을 추가하여 텍스트를 수직 중앙에 배치합니다.
                Spacer().frame(height: 150)
            }
            .frame(maxWidth: .infinity) // `VStack`이 가로로 최대한 넓게 확장되도록 합니다.
        } else {
            // 필터링된 아이템이 있을 경우 `LazyVGrid`를 사용하여 아이템을 표시합니다.
            // `LazyVGrid`는 화면에 보이는 부분만 렌더링하여 성능을 최적화합니다.
            LazyVGrid(columns: columns, spacing: 20) { // 정의된 `columns` 레이아웃을 사용하고, 행/열 간 간격을 20pt로 설정합니다.
                // `viewModel.filteredItems` 배열의 각 아이템에 대해 반복하여 `FlipCardItemView`를 생성합니다.
                // `ForEach`는 `Identifiable` 프로토콜을 준수하는 아이템에 최적화되어 있습니다.
                ForEach(items, id:\.productImageName) { (item:Product) in
                    // 각 아이템에 대한 `FlipCardItemView`를 인스턴스화합니다.
                    FlipCardItemView(
                        item: item, // 표시할 아이템 데이터
                        // `flippedID`를 바인딩으로 전달하여, 각 `FlipCardItemView`가
                        // 어떤 카드가 현재 뒤집혔는지 전역적으로 인지하고 제어할 수 있도록 합니다.
                        // 이를 통해 한 번에 하나의 카드만 뒤집히도록 구현할 수 있습니다.
                        flippedID: $flippedID,
                    )
                    .frame(height: 180) // 각 `FlipCardItemView`의 높이를 180pt로 고정합니다.
                }
            }
            .padding(.horizontal) // `LazyVGrid` 전체에 좌우 16pt (기본값) 패딩을 적용합니다.
            .padding(.top, 20)   // `LazyVGrid` 상단에 20pt의 패딩을 적용합니다.
        }
    }
}

// MARK: - 미리보기 설정
// `#Preview` 매크로는 SwiftUI 캔버스에서 뷰를 미리 볼 수 있게 해줍니다.
// 이 부분은 빌드 시에는 포함되지 않고, 개발 환경에서만 사용됩니다.
/*
#Preview {
    // `BrandPageViewModel`의 인스턴스를 생성합니다.
    let viewModel = BrandPageViewModel()
    // 미리보기를 위한 샘플 아이템 데이터를 `viewModel.items`에 할당합니다.
    viewModel.items = [
        BrandItem(frontImageName: "mockBanner1", name: "후드티", price: 59000, category: .top),
        BrandItem(frontImageName: "mockBanner2", name: "조거팬츠", price: 49000, category: .bottom),
        BrandItem(frontImageName: "mockBanner3", name: "체인 목걸이", price: 39000, category: .accessory)
    ]
    // `ItemGridView`를 반환하고, 생성한 `viewModel`을 `environmentObject`로 주입합니다.
    // 이렇게 해야 `ItemGridView` 내의 `@EnvironmentObject`가 올바르게 작동합니다.
    return ItemGridView()
        .environmentObject(viewModel)
}
*/
