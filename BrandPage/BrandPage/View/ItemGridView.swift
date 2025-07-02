import SwiftUI

struct ItemGridView: View {
    @EnvironmentObject var viewModel: BrandPageViewModel
    @State private var flippedID: UUID? = nil  // ✅ 추가된 바인딩 상태

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(viewModel.filteredItems) { item in
                FlipCardItemView(
                    item: item,
                    flippedID: $flippedID,
                    onDelete: {
                        // ❗️여기서는 예시로 삭제만 출력
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

#Preview {
    let viewModel = BrandPageViewModel()
    viewModel.items = [
        BrandItem(frontImageName: "mockBanner1", name: "후드티", price: 59000, category: .top),
        BrandItem(frontImageName: "mockBanner2", name: "조거팬츠", price: 49000, category: .bottom),
        BrandItem(frontImageName: "mockBanner3", name: "체인 목걸이", price: 39000, category: .accessory)
    ]
    return ItemGridView()
        .environmentObject(viewModel)
}
