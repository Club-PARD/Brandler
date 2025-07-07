import SwiftUI
struct DiggingStepView: View {
    let step: Int
    let progress: Double
    let diggingDistanceInKM: Double
    
    var body: some View {
        VStack(spacing: 12) {
            // ✅ 레벨 이름 + 설명 텍스트
            HStack {
                Text(levelTitle)
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundColor(step == 5 ? Color.GuideFontColor : .white)
                
                Spacer()
                
                Text(levellength)
                    .font(.system(size:12))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.trailing)
                
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            HStack {
                Text(levelDescription)
                    .font(.system(size:12))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.trailing)
                
                Spacer()
                
                Text(levelCount)
                    .font(.system(size:12))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 50, height: 15) // 텍스트 자체에 프레임 먼저 지정
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.Inter)
                    )
                    .overlay( // ✅ Stroke 추가
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.white, lineWidth: 1)
                    )
            }
            .padding(.horizontal)
            // ✅ 레벨 이미지
            Image("Digging_Level\(step)")
                .resizable()
                .frame(width: 336, height: 60)
            
            Spacer()
        }
        .padding(.vertical, 20)
        .frame(height: 130)
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - Text Info
    var levelTitle: String {
        switch step {
            case 1: return "🐚입문자 디깅러"
            case 2: return "🐟취향 디깅러"
            case 3: return "🪸탐험 디깅러"
            case 4: return "🐋심해 디깅러"
            case 5, 6: return "🌊마스터 브래들러"
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
            default: return "디깅러"
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
            default: return "브랜드를 향해 디깅 중이에요."
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        DiggingStepView(step: 1, progress: 0.2, diggingDistanceInKM: 0.4)
        DiggingStepView(step: 2, progress: 0.6, diggingDistanceInKM: 2.8)
        DiggingStepView(step: 3, progress: 1.0, diggingDistanceInKM: 6.0)
        DiggingStepView(step: 4, progress: 0.5, diggingDistanceInKM: 9.0)
        DiggingStepView(step: 5, progress: 0.8, diggingDistanceInKM: 10.0)
    }
    .padding()
    .background(Color.gray.opacity(0.05))
}
