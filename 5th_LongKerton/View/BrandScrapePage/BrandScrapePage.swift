import SwiftUI

struct BrandScrapePage: View {
    // 🔹 두 번째 모달(레벨 가이드) 표시 여부
    @State private var showSecondModal = false
    
    // 🔹 첫 번째 모달(리스트 모달) y 오프셋 값 (아래쪽으로 내릴 때 사용)
    @State private var offsetY: CGFloat = 0
    
    // 🔹 제스처 기반 드래그 오프셋 (사용 중엔 dragOffset에 위치 저장)
    @GestureState private var dragOffset: CGFloat = 0
    
    // 🔹 브랜드 리스트 및 상태 관리 ViewModel
    @StateObject private var viewModel = BrandViewModel()
    
    // 🔹 현재 뒤집힌 카드의 ID (FlipCardView 내부에서 참조)
    @State private var flippedID: UUID? = nil
    
    // 🔹 현재 보고 있는 페이지 인덱스 (TabView 연동용)
    @State private var currentPage: Int = 0
    
    // 🔹 한 페이지당 보여줄 카드 수 (3x3)
    private let itemsPerPage = 9
    
    // 🔹 브랜드 리스트를 페이지 단위로 나눈 2차원 배열
    var pagedBrands: [[Brand]] {
        stride(from: 0, to: viewModel.brands.count, by: itemsPerPage).map {
            Array(viewModel.brands[$0..<min($0 + itemsPerPage, viewModel.brands.count)])
        }
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.black.edgesIgnoringSafeArea(.all)
            // 🔸 배경: 상단은 검정, 하단은 블루로 이어지는 그라디언트
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(1.0),
                    Color.BackgroundBlue.opacity(0.9)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea() // 배경이 SafeArea를 넘어서도록 설정
            Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
            
            // 🔸 배경 이미지: 고래 배경 이미지 + 투명도 + 살짝 오른쪽 이동
            Image("whaleBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .opacity(0.3)
                .offset(x: +13)
                .opacity(0.8)
            
            VStack {
                // 🔸 타이틀 텍스트
                Text("My Digging List")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                Spacer().frame(height: 100) // 타이틀과 버튼 사이 여백
                
                // 🔸 '레벨 가이드 보기' 버튼
                Button(action: {
                    showSecondModal = true
                }) {
                    Text("단계 레벨 가이드 보기")
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                        .underline()
                }
                .padding(.bottom, 10)
                .padding(.leading, 230)
                // MARK: - 카드 + 페이지뷰 + 인디케이터
                VStack {
                    if viewModel.hasNoScrapedBrands {
                        ZStack {
                            Color.clear // 공간 채우기용 배경
                            Text("아직 스크랩한 브랜드가 없어요.")
                                .font(.system(size: 14))
                                .foregroundColor(.white.opacity(0.8))
                                .multilineTextAlignment(.center)
                        }
                        .frame(height: 440)
                    } else {
                        // ✅ 스크랩된 브랜드가 있을 때 기존 카드 뷰 표시
                        TabView(selection: $currentPage) {
                            ForEach(0..<pagedBrands.count, id: \.self) { pageIndex in
                                VStack(spacing: 0) {
                                    let brands = pagedBrands[pageIndex]
                                    let rowSize = 3
                                    let rowCount = brands.count / rowSize
                                    
                                    ForEach(0..<rowCount, id: \.self) { rowIndex in
                                        HStack(spacing: 20) {
                                            ForEach(0..<rowSize, id: \.self) { colIndex in
                                                let brandIndex = rowIndex * rowSize + colIndex
                                                let brand = brands[brandIndex]
                                                
                                                BrandFlipCardView(
                                                    brand: brand,
                                                    flippedID: $flippedID,
                                                    onDelete: {
                                                        viewModel.deleteBrand(brand)
                                                    }
                                                )
                                                .frame(width: 90, height: 130)
                                            }
                                        }
                                        .padding(.vertical, 8)
                                        
                                        if rowIndex < rowCount - 1 {
                                            Rectangle()
                                                .fill(Color.white.opacity(0.3))
                                                .frame(height: 1)
                                                .frame(width: 365)
                                        }
                                    }
                                }
                                .tag(pageIndex)
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .frame(height: 440)
                        
                        // ✅ 페이지 인디케이터
                        HStack(spacing: 8) {
                            ForEach(0..<pagedBrands.count, id: \.self) { index in
                                Circle()
                                    .fill(index == currentPage
                                          ? Color.ScrollPoint
                                          : Color.gray.opacity(0.3))
                                    .frame(width: 8, height: 8)
                            }
                        }
                        .padding(.top, 8)
                    }
                }
                // ✅ ⚠️ 아래 부분은 조건문 밖에 유지
                .padding(.vertical, 20)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
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
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        )
                )
                .overlay(
                    ZStack {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(Color.white.opacity(0.2), lineWidth: 2)
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(Color.white.opacity(0.4), lineWidth: 0.8)
                    }
                )
                .shadow(color: Color.black.opacity(0.1), radius: 8, y: 2)
                .opacity(0.9)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 40)
                .padding(.bottom, 8)
                Spacer() // 아래쪽 남은 공간 채우기
            }
            
            // MARK: - 오른쪽 SecondModalView 표시
            if showSecondModal {
                SecondModalView(isVisible: $showSecondModal)
            }
        }
        .animation(.easeInOut, value: showSecondModal) // 모달 애니메이션
        .onAppear {
            // 초기 오프셋 설정 (필요 시 드래그 모달 위치 기준)
            offsetY = UIScreen.main.bounds.height - 100
        }
    }
}

// 🔸 미리보기
#Preview {
    BrandScrapePage()
}
