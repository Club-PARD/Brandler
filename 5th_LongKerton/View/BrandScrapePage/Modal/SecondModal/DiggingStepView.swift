import SwiftUI

struct DiggingStepView: View {
    let step: Int                           // 현재 단계 번호
    let progress: Double                    // 진행도 (0.0 ~ 1.0)
    let diggingDistanceInKM: Double         // 디깅 거리 (킬로미터 기준)

    var body: some View {
        VStack(spacing: 3) { // stack 간의 여백 3 
            // 상단 텍스트 (레벨명 + 수심 범위)
            HStack {
                Text(levelTitle)            // 단계 제목
                    .font(.custom("Pretendard-Bold", size: 15))
                    .fontWeight(.bold)
                    .foregroundColor(step == 5 ? Color.GuideFontColor : .white)

                Spacer()

                Text(levellength)           // 수심 범위 텍스트
                    .font(.custom("Pretendard-Medium", size: 12))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.trailing)
                    
            }
            .padding(.horizontal,9)           // 양옆 여백
            .padding(.top, 10)              // 상단 여백
//            .border(.red,width:1)         // 제목 & 깊이 frame

            // 설명 텍스트 + 개수 정보
            HStack {
                Text(levelDescription)      // 각 단계의 설명
                    .font(.custom("Pretendard-Medium", size: 12))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.trailing)

                Spacer()

                Text(levelCount)            // 브랜드 수 범위
                    .font(.custom("Pretendard-Medium", size: 12))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 61, height: 15) // 고정 크기
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.Inter) // 배경색
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white, lineWidth: 1) // 테두리
                    )
            }
            .padding(.horizontal,9)           // 양옆 여백
            .padding(.bottom, 5)              // 하단 여백
//            .border(.red,width:1) // 설명 & 횟수

            // 단계별 이미지 표시
            Image("Digging_Level\(step)")
                .resizable()
                .frame(width: 345, height: 60) // 고정 크기
                .cornerRadius(9)              // 둥근 테두리

            Spacer()                          // 하단 여백
        }
        .padding(.vertical, 20)               // 위아래 패딩
        .frame(height: 130)                   // 고정 높이
        .frame(maxWidth: .infinity)           // 가로 최대 확장
//        .border(.red,width:1)// 단계별 frame
//        .padding(.top, 19)
    }
        

    // MARK: - 텍스트 정보 계산 프로퍼티

    var levelTitle: String {
        switch step {
            case 1: return "입문자 디깅러"
            case 2: return "취향 디깅러"
            case 3: return "탐험 디깅러"
            case 4: return "심해 디깅러"
            case 5, 6: return "마스터 브래들러"
            default: return "디깅러"
        }
    }

    var levellength: String {
        switch step {
            case 1: return "0 - 50m"
            case 2: return "50 - 200m"
            case 3: return "200 - 800m"
            case 4: return "800 - 1500m"
            case 5, 6: return "1500 - 3000m"
            default: return "-"
        }
    }

    var levelDescription: String {
        switch step {
            case 1: return "얕은 수심에서 디깅을 시작했어요."
            case 2: return "수심이 깊어지면 취향인 브랜드들이 모습을 드러내요."
            case 3: return "빛 아래 감춰졌던 브랜드를 찾고 있어요."
            case 4: return "조용한 심해에 고래가 나타나고 있어요."
            case 5, 6: return "바다의 끝에서 브랜드를 수면 위로 올리고 있어요."
            default: return "브랜드를 향해 디깅 중이에요."
        }
    }

    var levelCount: String {
        switch step {
            case 1: return "0-5개"
            case 2: return "6-10개"
            case 3: return "11-15개"
            case 4: return "16-20개"
            case 5, 6: return "21개 이상"
            default: return "-"
        }
    }
}

// 프리뷰 - 여러 단계 보기
#Preview {
    VStack(spacing: 16) {
        DiggingStepView(step: 1, progress: 0.2, diggingDistanceInKM: 0.4)
        DiggingStepView(step: 2, progress: 0.6, diggingDistanceInKM: 2.8)
        DiggingStepView(step: 3, progress: 1.0, diggingDistanceInKM: 6.0)
        DiggingStepView(step: 4, progress: 0.5, diggingDistanceInKM: 9.0)
        DiggingStepView(step: 5, progress: 0.8, diggingDistanceInKM: 10.0)
    }
    .padding()
    .background(Color.gray.opacity(1.0)) // 배경 설정
}
