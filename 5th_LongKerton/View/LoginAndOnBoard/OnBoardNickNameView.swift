
import SwiftUI

struct OnBoardNickNameView: View {
    let goToNext: () -> Void
    @Binding var nickname: String
    
    var body: some View {
        ZStack {
            Color.BgColor.ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer().frame(height: 30)
                GeometryReader { geometry in
                    let totalWidth = geometry.size.width
                    let progressWidth = totalWidth / 3

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
                .frame(height: 56)
                .padding(.horizontal, 18)
                .padding(.bottom, 25)
                
                HStack {
                    Text("닉네임을 설정해주세요")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(.LogBlue)
                    Spacer()
                }
                .padding(.leading, 18)
                .padding(.bottom, 40)
                HStack {
                    Text("닉네임")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.leading, 18)
                .padding(.bottom, 6)
                HStack {
                    ZStack(alignment: .leading) {
                        if nickname.isEmpty {
                            Text("닉네임을 입력해주세요")
                                .foregroundColor(Color.white.opacity(0.2))
                                .font(.system(size: 17))
                                .padding(.leading, 20)
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
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .cornerRadius(15)
                }
                .padding(.horizontal, 18)
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
                .padding(.horizontal, 16)

            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OnBoardNickNameView(goToNext: {}, nickname: .constant(""))
}


