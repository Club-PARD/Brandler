import SwiftUI

/// `ItemGridView`는 제품 아이템들을 그리드 형태로 표시하는 뷰입니다.
/// 필터링된 아이템 목록을 `BrandViewModel`에서 가져와 표시하며,
/// 아이템이 없을 경우 대체 메시지를 보여줍니다.
/// 각 아이템은 뒤집기 애니메이션을 포함하는 `FlipCardItemView`로 표시됩니다.
struct ItemGridView: View {
    @EnvironmentObject var viewModel: BrandViewModel
    @State private var flippedID: Int? = nil
    
    let items: [Product]
    
    let columns = [
        GridItem(.flexible(), spacing: 11.5),
        GridItem(.flexible(), spacing: 11.5),
        GridItem(.flexible(), spacing: 11.5)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            //             왼쪽 상단 흰색 아이템 개수 텍스트
            Text("\(items.count)개")
                .font(.custom("Pretendard-Medium", size: 12))
                .foregroundColor(Color.levelGray)
                .padding(.leading, 20)
                .padding(.top, 38) 
            
            if items.isEmpty {
                VStack(spacing: 12) {
                    Spacer().frame(height: 150)
                    
                    Text("아직 비어있습니다")
                        .font(.custom("Pretendard-Bold", size: 14))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    
                    Spacer().frame(height: 150)
                }
                .frame(maxWidth: .infinity)
            } else {
                LazyVGrid(columns: columns, spacing: 11.5) {
                    ForEach(items, id: \.productImageName) { (item: Product) in
                        FlipCardItemView(
                            item: item,
                            flippedID: $flippedID
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.top, 7)
            }
        }
    }
}
