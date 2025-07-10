import SwiftUI
struct ScrapedBrandGridView: View {
    let scrapedBrandList: [BrandCard]
    let pagedBrands: [[BrandCard?]]
    @Binding var currentPage: Int
    @Binding var flippedID: Int?
    var onDelete: (BrandCard) -> Void
    var onSelect: (BrandCard) -> Void

    var body: some View {
        VStack {
            Group {
                if scrapedBrandList.isEmpty {
                    VStack {
                        Spacer()
                        Text("아직 스크랩한 브랜드가 없어요.")
                            .font(.custom("Pretendard-Regular", size: 12))
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    TabView(selection: $currentPage) {
                        ForEach(0..<pagedBrands.count, id: \.self) { pageIndex in
                            let brands = pagedBrands[pageIndex]
                            VStack {
                                ForEach(0..<3, id: \.self) { row in
                                    HStack(spacing: 11) {
                                        ForEach(0..<3, id: \.self) { col in
                                            let index = row * 3 + col
                                            if let brand = brands[index] {
                                                BrandFlipCardView(
                                                    brand: brand,
                                                    flippedID: $flippedID,
                                                    onDelete: { onDelete(brand) },
                                                    onShop: { onSelect(brand) }
                                                )
                                            } else {
                                                Color.clear
                                            }
                                        }
                                        .frame(width: 99, height: 124)
                                    }
                                    if row < 2 {
                                        Rectangle()
                                            .fill(Color.white.opacity(0.3))
                                            .frame(height: 1)
                                            .frame(width: 360)
                                            .padding(.top, 15)
                                            .padding(.bottom, 15)
                                    }
                                }
                            }
                            .padding(.vertical, 30)
                            .padding(.top, 30)
                            .tag(pageIndex)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))

                    HStack(spacing: 8) {
                        ForEach(0..<pagedBrands.count, id: \.self) { index in
                            Circle()
                                .fill(index == currentPage ? Color.ScrollPoint : Color.nickBox)
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.top, 20)
                }
            }
        }
        .frame(height: 530) // ✅ 고정 높이 설정
        .padding(.bottom, 50)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.clear)
                .overlay(
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.Gradient1.opacity(0.5),
                                Color.Gradient2.opacity(0.5),
                                Color.Gradient3.opacity(0.5),
                                Color.Gradient4.opacity(0.5),
                                Color.Gradient5.opacity(0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .opacity(0.5)
                        .blur(radius: 0.3)

                        Color.white.opacity(0.24)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                )
        )
        .overlay(
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.2), lineWidth: 2)
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.4), lineWidth: 0.8)
            }
        )
        .shadow(color: Color.black.opacity(0.1), radius: 8, y: 2)
        .opacity(0.9)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 40)
        .padding(.bottom, 50)
    }
}
