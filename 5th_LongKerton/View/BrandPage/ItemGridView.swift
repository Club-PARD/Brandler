import SwiftUI

struct ItemGridView: View {
    // BrandPageViewModel을 환경 객체로 받아 사용 (필터링된 아이템 등)
    @EnvironmentObject var viewModel: BrandPageViewModel
    
    // 현재 뒤집힌 카드의 UUID를 추적하는 상태 변수 (nil이면 뒤집힌 카드 없음)
    @State private var flippedID: UUID? = nil
    
    // 3열 그리드 레이아웃 정의 (각 열 유연한 크기)
    let columns = [
        GridItem(.flexible()),   // 첫 번째 열
        GridItem(.flexible()),   // 두 번째 열
        GridItem(.flexible())    // 세 번째 열
    ]
    
    var body: some View {
        // 뷰모델에서 필터링된 아이템 목록 가져오기 (선택된 카테고리 기준)
        let items = viewModel.filteredItems
        
        // 아이템이 없을 경우 보여줄 빈 상태 UI
        if items.isEmpty {
            VStack(spacing: 12) {
                Spacer().frame(height: 150)   // 상단에 빈 공간 150pt 확보
                
                Text("아직 비어있습니다")      // 비어있음을 알리는 메시지
                    .font(.system(size: 14, weight: .medium))  // 14pt, medium weight 폰트
                    .foregroundColor(.gray)                     // 회색 글씨
                    .multilineTextAlignment(.center)            // 중앙 정렬
                
                Spacer().frame(height: 150)   // 하단에 빈 공간 150pt 확보
            }
            .frame(maxWidth: .infinity)       // 가로 최대 폭 차지
        } else {
            // 아이템이 있을 경우, 3열 그리드에 LazyVGrid로 표시
            LazyVGrid(columns: columns, spacing: 20) {
                // 필터링된 각 아이템에 대해 카드 뷰 생성
                ForEach(items) { item in
                    FlipCardItemView(
                        item: item,              // 아이템 데이터 전달
                        flippedID: $flippedID,  // 뒤집힌 카드 ID를 바인딩으로 전달 (상호작용 가능)
                        onDelete: {              // 삭제 액션 (임시로 출력용)
                            print("\(item.name) 삭제")
                        }
                    )
                    .frame(height: 180)          // 각 카드 높이 180pt 고정
                }
            }
            .padding(.horizontal)                 // 좌우 16pt 기본 패딩 적용
            .padding(.top, 20)                    // 상단 20pt 여백 추가
        }
    }
}

// MARK: - 미리보기 설정
#Preview {
    let viewModel = BrandPageViewModel()       // 뷰모델 인스턴스 생성
    // 샘플 아이템 3개 설정
    viewModel.items = [
        BrandItem(frontImageName: "mockBanner1", name: "후드티", price: 59000, category: .top),
        BrandItem(frontImageName: "mockBanner2", name: "조거팬츠", price: 49000, category: .bottom),
        BrandItem(frontImageName: "mockBanner3", name: "체인 목걸이", price: 39000, category: .accessory)
    ]
    return ItemGridView()
        .environmentObject(viewModel)          // 환경 객체로 뷰모델 전달
}
