import SwiftUI

struct OnBoardNickNameView: View {
    let goToNext: () -> Void
    @Binding var nickname: String
    var currentStep: Int = 0 // 0, 1, 2 중 현재 단계

    @EnvironmentObject var session: UserSessionManager

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
                .padding(.horizontal, 16)
                .padding(.bottom, 62)
                .padding(.top, 62)
                
                HStack {
                    Text("닉네임을 설정해주세요")
                        .font(.custom("Pretendard-Regular",size: 22))
                        .foregroundColor(.NickWhite)
                        .kerning(-0.45)
                    Spacer()
                }
                .padding(.leading, 24)
                .padding(.bottom, 36)
                
                HStack {
                    Text("닉네임")
                        .font(.custom("Pretendard-Light",size: 13))
                        .foregroundColor(.EditBox)
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.bottom, 8)
                
                HStack {
                    ZStack(alignment: .leading) {
                        if nickname.isEmpty {
                            Text("닉네임을 입력해주세요")
                                .foregroundColor(Color.EditBox)
                                .font(.custom("Pretendard-Medium",size: 15))
                                .padding(.leading, 24)
                        }
                        TextField("", text: $nickname)
                            .foregroundColor(.white)
                            .font(.custom("Pretendard-Medium",size: 15))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 30)
                    }
                    .background(Color.nickBox)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.nickBoxStroke, lineWidth: 3.5)
                    )
                    .cornerRadius(15)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 383)
                
                
            }
            .padding(.bottom, 100) // Prevents content from going under the button

            // 다음으로 버튼을 오버레이로 고정
            VStack {
                Spacer()
                Button(action: {
                    session.updateNickname(nickname)
                    goToNext()
                }) {
                    Text("다음으로")
                        .font(.custom("Pretendard-SemiBold",size: 16))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 80)
                        .background(nickname.isEmpty ? Color.NextButton : Color.lastBox)
                        .cornerRadius(100)
                }
                .disabled(nickname.isEmpty)
                .padding(.horizontal, 25)
                .padding(.bottom, 6)
            }
            .ignoresSafeArea(.keyboard) // Keeps button fixed even when keyboard is up
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OnBoardNickNameView(goToNext: {}, nickname: .constant(""))
        .environmentObject(UserSessionManager.shared)
}
