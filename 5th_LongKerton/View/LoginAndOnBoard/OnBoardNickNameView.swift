
import SwiftUI

struct OnBoardNickNameView: View {
    let goToNext: () -> Void
    @Binding var nickname: String
    var currentStep: Int = 0 // 0, 1, 2 중 현재 단계

    var body: some View {
        ZStack {
            Color.BgColor.ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer().frame(height: 30)
                
                // 동그라미 인디케이터
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
                    Text("닉네임을 설정해주세요")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(.NickWhite)
                    Spacer()
                }
                .padding(.leading, 24)
                .padding(.bottom, 40)
                HStack {
                    Text("닉네임")
                        .font(.system(size: 15))
                        .foregroundColor(.EditBox)
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.bottom, 6)
                
                HStack {
                    ZStack(alignment: .leading) {
                        if nickname.isEmpty {
                            Text("닉네임을 입력해주세요")
                                .foregroundColor(Color.EditBox)
                                .font(.system(size: 13))
                                .padding(.leading, 24)
                        }
                        TextField("", text: $nickname)
                            .foregroundColor(.white)
                            .font(.system(size: 17))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 30)
                    }
                    .background(Color.nickBox)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.nickBoxStroke, lineWidth: 2.5)
                    )
                    .cornerRadius(15)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 0)
                Spacer()
                Button(action: {
                    goToNext()
                }) {
                    Text("다음으로")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 80)
                        .background(Color.NextButton)
                        .cornerRadius(40)
                }
                .padding(.horizontal, 25)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}



#Preview {
    OnBoardNickNameView(goToNext: {}, nickname: .constant(""))
}


