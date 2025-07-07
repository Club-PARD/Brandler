import SwiftUI

struct BrandStepView: View {
    let step: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 16) {
                Image("Level\(step)")
                    .resizable()
                    .frame(width: 91, height: 91)
                    .padding()
                VStack(alignment: .leading, spacing: 8) {
                    Text(levelTitle)
                        .font(.system(size:15))
                        .foregroundColor(step == 5 ? Color.GuideFontColor : .white)
                    
                    Text(levelDescription)
                        .font(.system(size:12))
                        .foregroundColor(Color.NickWhite)
                        .foregroundColor(.gray)
                    
                    Text(levelCount)
                        .font(.system(size:10))
                        .frame(width: 63, height: 9) // 텍스트 자체에 프레임 먼저 지정
                        .foregroundColor(Color.NickWhite)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.Inter)
                        )
                        .overlay( // ✅ Stroke 추가
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                
                Spacer()
                
            }
        }
    }
    
    // 텍스트 프로퍼티들
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
    var levelDescription: String {
        switch step {
            case 1: return "막 디깅되기 시작한 브랜드에요."
            case 2: return "소수에게 주목받는 개성 있는 브랜드에요."
            case 3: return "꾸준히 디깅되며 존재감이 커진 브랜드에요."
            case 4: return "많은 디깅러가 찾고 있느느 핫한 브랜드예요."
            case 5, 6: return "가장 많이 디깅된 브랜드에요."
            default: return "브랜드를 향해 디깅 중이에요."
        }
    }
    
    var levelCount: String {
        switch step {
            case 1: return "10회"
            case 2: return "10-50회"
            case 3: return "50-200회"
            case 4: return "200-500회"
            case 5, 6: return "700회 이상"
            default: return "브랜드를 향해 디깅 중이에요."
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        BrandStepView(step: 1)
        BrandStepView(step: 2)
        BrandStepView(step: 3)
        BrandStepView(step: 4)
        BrandStepView(step: 5)
    }
    .padding()
    .background(Color.gray.opacity(0.1))
}
