import SwiftUI

struct BrandCardBack: View {
    let item: BrandItem
    let onDelete: () -> Void

    @State private var showDeleteAlert = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.gray.opacity(0.8)

            VStack(spacing: 8) {
                Spacer()
                Text(item.name)
                    .font(.headline)
                    .foregroundColor(.white)
                Text("\(item.price)원")
                    .font(.subheadline)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()

//            Button(action: {
//                showDeleteAlert = true
//            }) {
//                Image(systemName: "xmark")
//                    .foregroundColor(.white)
//                    .frame(width: 24, height: 24)
//                    .background(Color.black.opacity(0.6))
//                    .clipShape(Circle())
//            }
//            .padding(8)
//            .alert("정말 삭제하시겠습니까?", isPresented: $showDeleteAlert) {
//                Button("삭제", role: .destructive) {
//                    onDelete()
//                }
//                Button("취소", role: .cancel) {}
//            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
    }
}

#Preview {
    BrandCardBack(
        item: BrandItem(
            frontImageName: "mockBanner2",
            name: "테스트 아이템",
            price: 69000,
            category: .bottom
        ),
        onDelete: { print("삭제") }
    )
    .frame(width: 120, height: 180)
    .background(Color.gray)
}
