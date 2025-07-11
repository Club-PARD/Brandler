import SwiftUI

struct BrandFilterView: View {
    @StateObject var viewModel: BrandViewModel
    @Binding var currentState: AppState
    @Binding var previousState: AppState
    let brands: [GenreBrandCard]
    var selectedGenre: String = "전체"
    
    var filteredBrands: [GenreBrandCard] {
        selectedGenre == "전체"
        ? brands
        : brands.filter { $0.genre == selectedGenre }
    }
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.fixed(173)), count: 2), spacing: 10) {
            ForEach(filteredBrands, id: \.brandId) { brand in
                Button(action:{
                    viewModel.currentBrandId = brand.brandId
                    previousState = currentState
                    currentState = .brand
                }) {
                    ZStack(alignment: .topTrailing) {
                        // 카드 배경
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 173, height: 252)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color("CardGradiantblack").opacity(0),
                                        Color("CardGradiant").opacity(0.7)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .background(
                                Image(brand.brandBanner)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 173, height: 252)
                            )
                            .cornerRadius(12)

                        // ✅ 슬로건 텍스트 (우측 상단)
                        Text(brand.slogan)
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.trailing)
                            .lineLimit(2)
                            .truncationMode(.tail)
                            .frame(width: 120, alignment: .trailing)
                            .padding([.top, .trailing], 8)

                        // ✅ 하단 중앙 정렬된 로고 + 이름 (좌우 배치)
                        VStack {
                            Spacer()
                            HStack(spacing: 6) {
                                Image(brand.brandLogo)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .clipShape(Circle())

                                Text(brand.brandName)
                                    .font(.custom("Pretendard-Medium", size: 17))
                                    .foregroundColor(Color("BrandNameColor"))
                                    .lineLimit(1)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .frame(width: 147, height: 31)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color("BrandGroupColor"))
                                    .stroke(Color("BrandNameColor"), lineWidth: 2)
                            )
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 8)
                        }
                    }
                }
            }
        }
        .padding(0)
    }
}
