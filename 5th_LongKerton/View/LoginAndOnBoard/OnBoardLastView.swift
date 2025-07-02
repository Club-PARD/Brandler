
import SwiftUI

struct OnBoardLastView: View {
    let finish: () -> Void
    let nickname: String
    let selectedGenre: String

    var body: some View {
        ZStack {
            Color.BgColor.ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer().frame(height: 30)
                GeometryReader { geometry in
                    let totalWidth = geometry.size.width
                    let progressWidth = totalWidth
                    VStack(spacing: 8) {
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color.barBlack)
                                .frame(height: 10)
                            Capsule()
                                .fill(Color.barBlue)
                                .frame(width: progressWidth, height: 10)
                            
                        }
                    }
                    .frame(width: totalWidth)
                }
                .frame(height: 40)
                .padding(.horizontal, 18)
                .padding(.bottom, 25)
                
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("다 끝났어요!\n이제 고래를 발견하러 가볼까요? ")
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(.LogBlue)
                    }
                    Spacer()
                }
                .padding(.leading, 18)
                .padding(.bottom, 40)
                
                Text("고래 만나러 가는 일러")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: 120)
                    .background(Color(white: 0.85))
                    .padding(.horizontal, 40)
                    .padding(.bottom, 40)
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


