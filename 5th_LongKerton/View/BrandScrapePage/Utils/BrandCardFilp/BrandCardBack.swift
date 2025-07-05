import SwiftUI

struct BrandCardBack: View {
    let brand: MockBrand
    let onDelete: () -> Void
    let onGoToBrandPage: () -> Void  // ✅ 브랜드 페이지 이동 클로저

    @State private var showDeleteAlert = false

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

            HStack(spacing: 6) {
                // ✅ 브랜드 페이지 이동 버튼
                Button(action: {
                    onGoToBrandPage()
                }) {
                    Image("Shop")

                        .frame(width: 24, height: 24)
//                        .foregroundColor(.black)
//                        .background(Color.black.opacity(0.6))
//                        .clipShape(Circle())
                }
                Spacer()
                // ✅ 삭제 버튼
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

#Preview {
    BrandCardBack(
        brand: MockBrand(
            id: UUID(),
            name: "브랜드 B",
            genre: "미니멀",
            description: "디테일한 설명이 여기에 들어갑니다.",
            bannerImageName: "mockBanner2",
            logoImageName: "mockLogo2"
        ),
        onDelete: { print("삭제 테스트") },
        onGoToBrandPage: { print("브랜드 페이지로 이동!") }
    )
    .frame(width: 120, height: 180)
    .background(Color.gray)
}
