import SwiftUI // SwiftUI 프레임워크를 불러옴

struct BrandScrapePage: View { // 스크랩된 브랜드를 보여주는 메인 페이지 뷰 정의
    @State private var showSecondModal = false // 단계 레벨 가이드 모달 표시 여부 상태
    @State private var offsetY: CGFloat = 0 // 모달의 위치를 나타내는 오프셋 값
    @GestureState private var dragOffset: CGFloat = 0 // 드래그 중 실시간 위치 변화 감지용 상태
    @StateObject private var viewModel = BrandViewModel() // 브랜드 관련 데이터와 로직을 관리하는 뷰모델
    @State private var flippedID: UUID? = nil // 현재 뒤집힌 카드의 ID (단 하나만 뒤집히게 함)
    @State private var currentPage: Int = 0 // 현재 TabView 페이지 인덱스

    private let itemsPerPage = 9 // 한 페이지에 표시할 카드 수 (3행 * 3열)

    // 브랜드 배열을 9개씩 끊어서 2차원 배열로 반환 (페이지 단위 구성)
    var pagedBrands: [[Brand]] {
        stride(from: 0, to: viewModel.brands.count, by: itemsPerPage).map {
            // 범위를 벗어나지 않도록 마지막 페이지 처리
            Array(viewModel.brands[$0..<min($0 + itemsPerPage, viewModel.brands.count)])
        }
    }

    var body: some View { // View의 본문 정의
        ZStack(alignment: .topTrailing) { // 상단 우측 정렬된 ZStack: 배경과 카드 등 전체 구조
            Color.black.edgesIgnoringSafeArea(.all) // 배경을 검정색으로 전체 채움

            LinearGradient( // 위에서 아래로 색이 바뀌는 그라디언트 배경
                gradient: Gradient(colors: [
                    Color.black.opacity(0.8), // 위쪽은 완전 검정
                    Color.BackgroundBlue.opacity(1.0) // 아래쪽은 파란 배경
                ]),
                startPoint: .top, // 시작점: 위쪽
                endPoint: .bottom // 끝점: 아래쪽
                
            )
            .ignoresSafeArea() // 화면 전체 적용
            
            Color.black.opacity(0.8).edgesIgnoringSafeArea(.all) // 반투명 검정 오버레이 추가

            Image("whaleBackground") // 고래 배경 이미지 추가
                .resizable() // 이미지 리사이징 가능하게
                .scaledToFill() // 비율 유지하며 채우기
                .ignoresSafeArea() // 화면 전체에 걸쳐 표시
                .opacity(0.8) // 반투명하게 설정
                .offset(x: 13) // 오른쪽으로 살짝 이동

            VStack { // 콘텐츠들을 수직 정렬하는 VStack
                Text("My Digging List") // 페이지 제목 텍스트
                    .font(.system(size: 16)) // 폰트 크기 설정
                    .foregroundColor(.white) // 텍스트 색상 흰색
                    .padding(.top, 20) // 상단 여백 추가

                Spacer().frame(height: 100) // 제목 아래에 여백 추가

                Button(action: { // 단계 레벨 가이드 보기 버튼
                    showSecondModal = true // 버튼 클릭 시 모달 열기
                }) {
                    Text("단계 레벨 가이드 보기") // 버튼에 표시할 텍스트
                        .font(.system(size: 10)) // 작은 폰트 크기
                        .foregroundColor(.gray) // 회색 텍스트
                        .underline() // 밑줄 스타일
                }
                .padding(.bottom, 10) // 아래쪽 여백
                .padding(.leading, 230) // 오른쪽 정렬처럼 보이도록 왼쪽 여백 추가

                VStack { // 카드 뷰 전체 영역
                    if viewModel.hasNoScrapedBrands { // 스크랩한 브랜드가 없을 경우
                        ZStack { // 배경이 없는 안내 문구 배치
                            Color.clear // 공간 확보용 투명 배경
                            Text("아직 스크랩한 브랜드가 없어요.") // 사용자에게 보여줄 안내 문구
                                .font(.system(size: 14)) // 폰트 크기
                                .foregroundColor(.white.opacity(0.8)) // 흐린 흰색 텍스트
                                .multilineTextAlignment(.center) // 가운데 정렬
                        }
                        .frame(height: 440) // 카드 영역 크기 유지
                    } else {
                        TabView(selection: $currentPage) { // 브랜드가 있을 경우 페이지 단위로 표시
                            ForEach(0..<pagedBrands.count, id: \.self) { pageIndex in // 각 페이지 순회
                                VStack(spacing: 0) { // 세로 정렬 (카드 행들)
                                    let brands = pagedBrands[pageIndex] // 현재 페이지 브랜드 배열
                                    let rowSize = 3 // 한 줄당 카드 3개
                                    let rowCount = brands.count / rowSize // 총 줄 수 계산

                                    ForEach(0..<rowCount, id: \.self) { rowIndex in // 각 줄에 대해
                                        HStack(spacing: 20) { // 카드들을 가로 정렬
                                            ForEach(0..<rowSize, id: \.self) { colIndex in // 각 카드
                                                let brandIndex = rowIndex * rowSize + colIndex // 현재 카드 인덱스 계산
                                                let brand = brands[brandIndex] // 해당 브랜드 가져오기

                                                BrandFlipCardView( // 카드 뷰 표시
                                                    brand: brand, // 브랜드 데이터 전달
                                                    flippedID: $flippedID, // 현재 뒤집힌 카드 ID 공유
                                                    onDelete: { // 삭제 버튼 클릭 시 처리
                                                        viewModel.deleteBrand(brand) // 뷰모델에서 삭제
                                                    }
                                                )
                                                .frame(width: 90, height: 130) // 카드 크기 지정
                                            }
                                        }
                                        .padding(.vertical, 8) // 카드 행 위아래 간격

                                        if rowIndex < rowCount - 1 { // 마지막 줄이 아닐 경우 구분선 추가
                                            Rectangle()
                                                .fill(Color.white.opacity(0.3)) // 연한 흰색 선
                                                .frame(height: 1) // 선 두께
                                                .frame(width: 365) // 선 길이
                                        }
                                    }
                                }
                                .tag(pageIndex) // TabView에서 현재 페이지 구분
                                .frame(maxWidth: .infinity) // 가로 폭 최대
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never)) // 페이지 인디케이터 숨김
                        .frame(height: 440) // 카드 뷰 높이 고정

                        HStack(spacing: 8) { // 페이지 인디케이터 점 배열
                            ForEach(0..<pagedBrands.count, id: \.self) { index in // 각 페이지마다 점 생성
                                Circle()
                                    .fill(index == currentPage
                                          ? Color.ScrollPoint // 현재 페이지는 파란색
                                          : Color.gray.opacity(0.3)) // 나머지는 흐린 회색
                                    .frame(width: 8, height: 8) // 점 크기
                            }
                        }
                        .padding(.top, 8) // 위쪽 여백
                    }
                }
                .padding(.vertical, 20) // 위아래 여백

                .background( // 카드 영역 배경
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.clear) // 기본 배경 투명
                        .overlay( // 그 위에 오버레이 추가
                            ZStack {
                                LinearGradient( // 다단계 색상 그라디언트
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
                                .opacity(0.5) // 반투명
                                .blur(radius: 0.3) // 약간 흐림 처리

                                Color.white.opacity(0.24) // 추가 흰색 반투명 레이어
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 12)) // 모서리 둥글게
                        )
                )
                .overlay( // 테두리 2중 처리
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.2), lineWidth: 2)
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.4), lineWidth: 0.8)
                    }
                )
                .shadow(color: Color.black.opacity(0.1), radius: 8, y: 2) // 그림자 효과
                .opacity(0.9) // 전체 투명도 조절
                .frame(maxWidth: .infinity) // 가로 최대
                .padding(.horizontal, 40) // 좌우 여백
                .padding(.bottom, 8) // 아래 여백

                Spacer() // 아래 공간 채우기용
            }

            if showSecondModal { // 모달이 열렸을 때
                SecondModalView(isVisible: $showSecondModal) // 모달 뷰 표시
            }
        }
        .animation(.easeInOut, value: showSecondModal) // 모달 등장/사라짐 애니메이션
        .onAppear {
            offsetY = UIScreen.main.bounds.height - 100 // 모달 초기 위치 설정
        }
    }
}

#Preview {
    BrandScrapePage() // Xcode 프리뷰를 위한 기본 진입 뷰
}
