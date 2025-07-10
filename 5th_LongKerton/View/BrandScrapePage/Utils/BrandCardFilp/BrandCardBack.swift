import SwiftUI

struct BrandCardBack: View {
    let brand: BrandCard
    let onDelete: () -> Void
    var onShop: () -> Void = {}

    @State private var showDeleteAlert = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(brand.brandBanner)
                .resizable()
                .scaledToFill()
                .frame(width: 99, height: 124)
                .opacity(0.5)
                .clipped()

            VStack {
                Spacer()

                Text(brand.slogan)
                    .font(.system(size: 10))
                    .foregroundColor(.white)
                    .padding()

                Spacer()
            }

            HStack(spacing: 8) {
                NavigationLink(destination: BrandPage(brandId: brand.brandId)) {
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
                        .foregroundColor(.white).opacity(0.6)
                        .frame(width: 10, height: 10)
//                        .background(Color.black.opacity(0.6))
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
