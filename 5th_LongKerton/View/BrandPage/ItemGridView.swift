import SwiftUI

struct ItemGridView: View {
    @EnvironmentObject var viewModel: BrandViewModel
    @State private var flippedID: UUID? = nil

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        if viewModel.filteredItems.isEmpty {
            VStack(spacing: 12) {
                Spacer().frame(height: 150)
                
                Text("아직 비어있습니다")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                Spacer().frame(height: 150)
            }
            .frame(maxWidth: .infinity)
        } else {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.filteredItems) { item in
                    FlipCardItemView(
                        item: item,
                        flippedID: $flippedID,
                        onDelete: {
                            print("\(item.name) 삭제")
                        }
                    )
                    .frame(height: 180)
                }
            }
            .padding(.horizontal)
            .padding(.top, 20)
        }
    }
}
// MARK: - 미리보기 설정
//#Preview {
//    let viewModel = BrandPageViewModel()       // 뷰모델 인스턴스 생성
//    // 샘플 아이템 3개 설정
//    viewModel.items = [
//        BrandItem(frontImageName: "mockBanner1", name: "후드티", price: 59000, category: .top),
//        BrandItem(frontImageName: "mockBanner2", name: "조거팬츠", price: 49000, category: .bottom),
//        BrandItem(frontImageName: "mockBanner3", name: "체인 목걸이", price: 39000, category: .accessory)
//    ]
//    return ItemGridView()
//        .environmentObject(viewModel)          // 환경 객체로 뷰모델 전달
//}
