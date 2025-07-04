import SwiftUI  // ✅ 이 줄이 꼭 필요함!

struct BrandCardBack: View {
    let brand: MockBrand
    let onDelete: () -> Void

    @State private var showDeleteAlert = false  // ✅ 삭제 알림 상태

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(brand.bannerImageName)
                .resizable()
                .scaledToFill()
                .opacity(0.5)
                .clipped()

            VStack {
                Spacer()
                Text(brand.description)
                    .font(.system(size: 10))
                    .foregroundColor(.white)
                    .padding()
                Spacer()
            }

            Button(action: {
                showDeleteAlert = true  // ✅ 버튼 누르면 알림 표시
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .frame(width: 24, height: 24)
                    .background(Color.black.opacity(0.6))
                    .clipShape(Circle())
            }
            .padding(8)
            .alert("정말 삭제하시겠습니까?", isPresented: $showDeleteAlert) {
                Button("삭제", role: .destructive) {
                    onDelete()
                }
                Button("취소", role: .cancel) {}
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
    }
}


//#Preview {
//    BrandCardBack(
//        brand: MockBrand(
//            id: UUID(),
//            name: "브랜드 B",
//            genre: "미니멀",
//            description: "디테일한 설명이 여기에 들어갑니다.",
//            bannerImageName: "mockBanner2",
//            logoImageName: "mockLogo2"
//        ),
//        onDelete: { print("삭제 테스트") }
//    )
//    .frame(width: 120, height: 180)
//    .background(Color.gray)
//}
