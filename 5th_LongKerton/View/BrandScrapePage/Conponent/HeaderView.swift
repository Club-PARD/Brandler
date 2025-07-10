import SwiftUI

struct HeaderView: View {
    var onGuideTap: () -> Void

    var body: some View {
        VStack {
            Text("My 디깅함")
                .font(.custom("Pretendard-Bold", size: 15))
                .foregroundColor(.white)
                .padding(.top, 20)

            Spacer().frame(height: 63)

            Button(action: onGuideTap) {
                Text("단계 레벨 가이드 보기")
                    .font(.custom("Pretendard-Light", size: 10))
                    .foregroundColor(.gray)
                    .underline()
            }
            .padding(.bottom, 10)
            .padding(.leading, 230)
        }
    }
}
