import SwiftUI

struct BrandScrapePage: View {
    @State private var showSecondModal = false
    @State private var offsetY: CGFloat = 0
    @GestureState private var dragOffset: CGFloat = 0

    @StateObject private var viewModel = BrandViewModel()
    @State private var flippedID: UUID? = nil
    @State private var currentPage: Int = 0

    @State private var selectedBrand: Brand? = nil
    @State private var showBrandPage: Bool = false

    private let itemsPerPage = 9

    // MARK: - 3x3 그리드 포맷을 유지한 페이지 분할
    var pagedBrands: [[Brand?]] {
        stride(from: 0, to: viewModel.brands.count, by: itemsPerPage).map { start in
            var slice = Array(viewModel.brands[start..<min(start + itemsPerPage, viewModel.brands.count)]).map { Optional($0) }
            while slice.count < itemsPerPage {
                slice.append(nil)
            }
            return slice
        }
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                Color.black.opacity(0.8).edgesIgnoringSafeArea(.all)
                Image("whaleBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .opacity(0.8)
                    .offset(x: 13)

                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.black.opacity(0.8),
                        Color.BackgroundBlue.opacity(1.0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                ).ignoresSafeArea()

                VStack {
                    Text("My 디깅함")
                        .font(.custom("Pretendard-Bold", size: 15))
                        .foregroundColor(.white)
                        .padding(.top, 20)

                    Spacer().frame(height: 100)

                    Button(action: {
                        showSecondModal = true
                    }) {
                        Text("단계 레벨 가이드 보기")
                            .font(.custom("Pretendard-Light", size: 10))
                            .foregroundColor(.gray)
                            .underline()
                    }
                    .padding(.bottom, 10)
                    .padding(.leading, 230)

                    VStack {
                        if viewModel.hasNoScrapedBrands {
                            ZStack {
                                Color.clear
                                Text("아직 스크랩한 브랜드가 없어요.")
                                    .font(.custom("Pretendard-Regular", size: 12))
                                    .foregroundColor(.white.opacity(0.8))
                                    .multilineTextAlignment(.center)
                            }
                            .frame(height: 440)
                        } else {
                            TabView(selection: $currentPage) {
                                ForEach(0..<pagedBrands.count, id: \.self) { pageIndex in
                                    let brands = pagedBrands[pageIndex]

                                    VStack(spacing: 0) {
                                        ForEach(0..<3, id: \.self) { row in
                                            HStack(spacing: 20) {
                                                ForEach(0..<3, id: \.self) { col in
                                                    let index = row * 3 + col
                                                    if let brand = brands[index] {
                                                        BrandFlipCardView(
                                                            brand: brand,
                                                            flippedID: $flippedID,
                                                            onDelete: {
                                                                viewModel.deleteBrand(brand)
                                                            },
                                                            onShop: {
                                                                selectedBrand = brand
                                                                showBrandPage = true
                                                            }
                                                        )
                                                    } else {
                                                        Color.clear
                                                    }
                                                }
                                                .frame(width: 90, height: 130)
                                            }
                                            .padding(.horizontal, 11)

                                            if row < 2 {
                                                Rectangle()
                                                    .fill(Color.white.opacity(0.3))
                                                    .frame(height: 1)
                                                    .frame(width: 360)
                                                    .padding(.horizontal, 16)
                                                    .padding(.vertical, 13) // 36 간격
                                            }
                                        }
                                    }
                                    .padding(.vertical, 36)
                                    .tag(pageIndex)
                                }
                            }
                            .tabViewStyle(.page(indexDisplayMode: .never))
                            .frame(height: 440)

                            HStack(spacing: 8) {
                                ForEach(0..<pagedBrands.count, id: \.self) { index in
                                    Circle()
                                        .fill(index == currentPage ? Color.ScrollPoint : Color.gray.opacity(0.3))
                                        .frame(width: 8, height: 8)
                                }
                            }
                            .padding(.top, 8)
                        }
                    }
                    .padding(.vertical, 20)
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
                    .padding(.bottom, 8)

                    Spacer()
                }

                if showSecondModal {
                    SecondModalView(isVisible: $showSecondModal)
                }
            }
            .onAppear {
                offsetY = UIScreen.main.bounds.height - 100
            }
            .navigationDestination(isPresented: $showBrandPage) {
                if let brand = selectedBrand {
                    BrandPage(brand: brand)
                }
            }
        }
    }
}

#Preview {
    BrandScrapePage()
}
