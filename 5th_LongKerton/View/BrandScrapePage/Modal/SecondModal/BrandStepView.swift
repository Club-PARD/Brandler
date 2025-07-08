import SwiftUI

// 브랜드의 단계 정보를 보여주는 뷰
struct BrandStepView: View {
    let step: Int // 현재 단계 번호
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) { // 전체 수직 스택
            HStack(spacing: 22) { // 이미지 + 텍스트 수평 배치
                Image("Level\(step)") // 단계에 해당하는 고래 이미지
                    .resizable() // 크기 조절 가능하게 설정
                    .frame(width: 91, height: 91) // 이미지 크기 고정
                    .padding() // 이미지 주변 여백
                
                VStack(alignment: .leading, spacing: 0) { // 텍스트들 수직 정렬
                    Text(levelTitle) // 단계 제목 텍스트
                        .font(.custom("Pretendard-Bold", size: 15)) // 커스텀 폰트
                        .foregroundColor(step == 5 ? Color.GuideFontColor : .white) // 5단계일 때 색상 다르게
                    
                    Text(levelDescription) // 단계 설명 텍스트
                        .font(.custom("Pretendard-Medium", size: 12)) // 커스텀 폰트
                        .foregroundColor(Color.NickWhite) // 폰트 색상
                        .foregroundColor(.gray) // 중복 설정됨 (위의 색상 덮어씀)
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                    
                    Text(levelCount) // 디깅 횟수 텍스트
                        .font(.custom("Pretendard-Regular", size: 10)) // 폰트 설정
                        .frame(width: 63, height: 15) // 텍스트 박스 크기 고정
                        .foregroundColor(Color.NickWhite) // 텍스트 색상
                        .background(
                            RoundedRectangle(cornerRadius: 12) // 배경 둥근 사각형
                                .fill(Color.Inter) // 배경색 지정
                        )
                        .overlay( // 테두리 덧붙이기
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white, lineWidth: 1) // 흰색 외곽선
                        )
                        .padding(.top , 5)
                }
                
                Spacer() // 오른쪽 정렬 공간 확보
            }
//            .padding(.horizontal, 19) 
        }
//        .padding(.top,42)
    }
    
    // 단계별 타이틀 텍스트 반환
    var levelTitle: String {
        switch step {
            case 1: return "Lv 1. 파일럿 웨일"
            case 2: return "Lv 2. 밍크 고래"
            case 3: return "Lv 3. 범고래"
            case 4: return "Lv 4. 혹등고래"
            case 5, 6: return "Lv 5. 흰수염고래"
            default: return "디깅러"
        }
    }

    // 단계별 설명 텍스트 반환
    var levelDescription: String {
        switch step {
            case 1: return "막 디깅되기 시작한 브랜드에요."
            case 2: return "소수에게 주목받는 개성 있는 브랜드에요."
            case 3: return "꾸준히 디깅되며 존재감이 커진 브랜드에요."
            case 4: return "많은 디깅러가 찾고 있는 핫한 브랜드예요."
            case 5, 6: return "가장 많이 디깅된 브랜드에요."
            default: return "브랜드를 향해 디깅 중이에요."
        }
    }

    // 단계별 디깅 횟수 텍스트 반환
    var levelCount: String {
        switch step {
            case 1: return "10회 이하"
            case 2: return "10-50회"
            case 3: return "50-200회"
            case 4: return "200-500회"
            case 5, 6: return "700회 이상"
            default: return "브랜드를 향해 디깅 중이에요."
        }
    }
}

// 프리뷰: 여러 단계를 리스트로 확인
#Preview {
    VStack(spacing: 20) {
        BrandStepView(step: 1)
        BrandStepView(step: 2)
        BrandStepView(step: 3)
        BrandStepView(step: 4)
        BrandStepView(step: 5)
    }
    .padding() // 외부 여백
    .background(Color.gray.opacity(1.0)) // 배경 회색 처리
}
