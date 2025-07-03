
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
                .padding(.bottom, 25)
                
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {

                        Text("패션을 찾아 떠나는 잠수부,\n디깅러가 되신 걸 환영해요!")
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(.LogBlue)
                    }
                    Spacer()
                }
                .padding(.leading, 16)
                .padding(.bottom, 120)
                
                Image("whale_char")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 240)
                Spacer()
                
                Button(action: {
                    finish()
                }) {
                    Text("디깅하러 고고링")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 80)
                        .background(Color.barBlue)
                        .cornerRadius(40)
                }
                .padding(.horizontal, 16)
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OnBoardLastView(finish: {}, nickname: "홍길동", selectedGenre: "아메카지")
}


