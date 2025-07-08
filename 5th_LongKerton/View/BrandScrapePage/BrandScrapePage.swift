/**
 좌우 여백에 대한 피드백 듣기
 
 */

import SwiftUI

// MARK: - 브랜드 스크랩(디깅함) 메인 페이지
struct BrandScrapePage: View {
    // MARK: - 상태 변수들
    
    @State private var showSecondModal = false           // "단계 레벨 가이드 보기" 모달 표시 여부
    @State private var offsetY: CGFloat = 0              // 모달 뷰 위치 조정용 오프셋
    @GestureState private var dragOffset: CGFloat = 0    // 드래그 제스처 상태 (모달용)
    
    @StateObject private var viewModel = BrandViewModel() // 브랜드 및 상품 상태 관리용 ViewModel
    @State private var flippedID: UUID? = nil             // 현재 뒤집힌 카드의 ID (카드 하나만 뒤집히게 하기 위함)
    @State private var currentPage: Int = 0               // TabView(페이지네이션)의 현재 인덱스
    
    @State private var selectedBrand: Brand? = nil        // shop 버튼 클릭 시 선택된 브랜드
    @State private var showBrandPage: Bool = false        // 브랜드 상세 페이지 이동 트리거
    
    private let itemsPerPage = 9 // 한 페이지에 보여줄 카드 수 (3x3 레이아웃)
    
    // MARK: - 페이지 단위로 브랜드 분할
    var pagedBrands: [[Brand]] {
        // 브랜드 배열을 9개씩 잘라서 2차원 배열로 구성 (TabView에 사용)
        stride(from: 0, to: viewModel.brands.count, by: itemsPerPage).map {
            Array(viewModel.brands[$0..<min($0 + itemsPerPage, viewModel.brands.count)])
        }
    }
    
    // MARK: - 본문 UI
    var body: some View {
        NavigationStack { // 브랜드 상세 페이지로의 내비게이션을 위해 사용
            ZStack(alignment: .topTrailing) {
                
                // MARK: - 배경 설정
                Color.black.opacity(0.8).edgesIgnoringSafeArea(.all) // 어두운 배경
                Image("whaleBackground") // 고래 이미지 배경
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .opacity(0.8)
                    .offset(x: 13)
                
                // 파란색 그라디언트 배경 추가
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.black.opacity(0.8),
                        Color.BackgroundBlue.opacity(1.0)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                ).ignoresSafeArea()
                
                // MARK: - 전체 콘텐츠
                VStack {
                    // 상단 타이틀
                    Text("My 디깅함")
                        .font(.custom("Pretendard-Bold", size: 15))
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    Spacer().frame(height: 100) // 상단 여백
                    
                    // "단계 레벨 가이드 보기" 버튼
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
                    
                    // MARK: - 카드 영역
                    VStack {
                        if viewModel.hasNoScrapedBrands {
                            // 스크랩한 브랜드가 없을 때 안내 문구
                            ZStack {
                                Color.clear
                                Text("아직 스크랩한 브랜드가 없어요.")
                                    .font(.custom("Pretendard-Regular", size: 12))
                                    .foregroundColor(.white.opacity(0.8))
                                    .multilineTextAlignment(.center)
                            }
                            .frame(height: 440)
                        } else {
                            // 브랜드가 있을 때 카드 페이지 표시
                            TabView(selection: $currentPage) {
                                ForEach(0..<pagedBrands.count, id: \.self) { pageIndex in
                                    VStack(spacing: 0) {
                                        let brands = pagedBrands[pageIndex]
                                        let rowSize = 3 // 한 줄에 3개
                                        let rowCount = (brands.count + 2) / 3
                                        
                                        ForEach(0..<rowCount, id: \.self) { rowIndex in
                                            HStack(spacing: 20) {
                                                ForEach(0..<rowSize, id: \.self) { colIndex in
                                                    let brandIndex = rowIndex * rowSize + colIndex
                                                    if brandIndex < brands.count {
                                                        let brand = brands[brandIndex]
                                                        
                                                        // MARK: - 브랜드 카드 뷰 (플립 포함)
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
                                                        .frame(width: 90, height: 130)
                                                    } else {
                                                        Spacer() // 부족한 칸은 비워둠
                                                    }
                                                }
                                            }
                                            .padding(.vertical, 8)
                                            
                                            // 줄 사이에 구분선 추가
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
                            .tabViewStyle(.page(indexDisplayMode: .never)) // 페이지 인디케이터 숨김
                            .frame(height: 440)
                            
                            // 페이지 인디케이터 점
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
                    
                    // MARK: - 카드 영역 배경 + 테두리 + 그림자
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
                    
                    Spacer() // 하단 여백
                }
                
                // MARK: - 두 번째 모달 (단계 레벨 가이드)
                if showSecondModal {
                    SecondModalView(isVisible: $showSecondModal)
                }
            }
            
            // 모달 위치 초기화
            .onAppear {
                offsetY = UIScreen.main.bounds.height - 100
            }
            
            // MARK: - 브랜드 상세 페이지로 내비게이션
            .navigationDestination(isPresented: $showBrandPage) {
                if let brand = selectedBrand {
                    BrandPage(brand: brand) // 선택된 브랜드의 상세 페이지로 이동
                }
            }
        }
    }
}

#Preview {
    BrandScrapePage()
}
