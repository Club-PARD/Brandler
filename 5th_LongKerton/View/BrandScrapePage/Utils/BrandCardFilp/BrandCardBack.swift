import SwiftUI

struct BrandCardBack: View {
    let brand: Brand
    let onDelete: () -> Void
    var onShop: () -> Void = {}  // ✅ 기본값 제공 (선택적)

    @State private var showDeleteAlert = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(brand.brandBannerUrl)
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

            // ✅ 상단 버튼 영역
            HStack(spacing: 8) {
                Button(action: {
                    onShop()  // 상점 액션
                }) {
                    Image("shop")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(6)
                        .background(Color.black.opacity(0.0))
                        .clipShape(Circle())
                }
                Spacer()
                Button(action: {
                    showDeleteAlert = true
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                        .background(Color.black.opacity(0.6))
                        .clipShape(Circle())
                }
                .alert("정말 삭제하시겠습니까?", isPresented: $showDeleteAlert) {
                    Button("삭제", role: .destructive) {
                        onDelete()
                    }
                    Button("취소", role: .cancel) {}
                }
            }
            .padding(8)
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
    }
}
