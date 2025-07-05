
import SwiftUI

struct OnBoardLastView: View {
    let finish: () -> Void
    let nickname: String
    let selectedGenre: String
    var currentStep: Int = 2 // 0, 1, 2 중 현재 단계
    
    
    var body: some View {
        ZStack {
            Color.BgColor.ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer().frame(height: 30)
                
                HStack(spacing: 8) {
                    ForEach(0..<3) { idx in
                        Circle()
                            .fill(idx == currentStep ? Color.barBlue : Color.barBlack)
                            .frame(width: 10, height: 10)
                    }
                }
                .frame(height: 56)
                .padding(.horizontal, 16)
                .padding(.bottom, 35)
                
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("새로운 브랜드를 찾아 떠나는 탐험,")
                            .font(.system(size: 23, weight: .medium))
                            .foregroundColor(.NickWhite)
                        Text("디깅러가 되신 걸 환영해요!")
                            .font(.system(size: 23, weight: .medium))
                            .foregroundColor(.NickWhite)
                    }
                    Spacer()
                }
                .padding(.leading, 24)
                .padding(.bottom, 75)
                
                Image("charWithCir")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 240)
                    .padding(.leading, 55)
                    .padding(.bottom, 38)

                Spacer()
                
                VStack(alignment: .center, spacing: 8) {
                    (
                        Text("좋아하는 브랜드를 발견하고 모으는 사람.\n그걸 우리는 ")
                        + Text("'디깅러'").bold()
                        + Text("라고 부릅니다.\n- \n이제, 디깅을 시작할 시간이에요. 🌊")
                    )
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.NickWhite)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                }

                Spacer()
                    .padding(.leading, 24)
                    .padding(.bottom, 20)
                
                Button(action: {
                    finish()
                }) {
                    Text("디깅하러 고고링")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 80)
                        .background(Color.lastBox)
                        .cornerRadius(40)
                }
                .padding(.horizontal, 25)
                
            }
            .navigationBarBackButtonHidden(true)
        }
        
    }
}


#Preview {
    OnBoardLastView(finish: {}, nickname: "홍길동", selectedGenre: "아메카지")
}


