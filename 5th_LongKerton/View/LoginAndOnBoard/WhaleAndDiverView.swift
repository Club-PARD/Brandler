import SwiftUI


struct WhaleAndDiverView: View {
    var body: some View {
        ZStack {
            Color.backgroundBlueGray
                .ignoresSafeArea()
            
            VStack {
                Spacer().frame(height: 100)
                
                // 상단: 원 + 텍스트
               // VStack(alignment: .center, spacing: 12) {
                    Circle()
                        .fill(Color(white: 0.85))
                        .frame(width: 16, height: 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 32)
                    Text("단계가 있어요")
                        .font(.title3)
                        .foregroundColor(.black)
               // }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 32)
                
                Spacer().frame(height: 32)
                
                // 두 개의 회색 박스
                VStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 1)
                        .fill(Color(white: 0.85))
                        .frame(height: 100)
                    RoundedRectangle(cornerRadius: 1)
                        .fill(Color(white: 0.85))
                        .frame(height: 20)
                    RoundedRectangle(cornerRadius: 1)
                        .fill(Color(white: 0.85))
                        .frame(height: 100)
                }
                .padding(.horizontal, 60)
                
                Spacer().frame(height: 32)
                
                // 안내 텍스트
                Text("이런 식으로 단계가 변할 때에 대한 알림창을 띄우고 할 ~~")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                
                Spacer()
                
                // 하단 버튼
                Button(action: {
                    // 버튼 액션
                }) {
                    Text("디깅하러 고고링")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .background(Color(white: 0.7))
                        .cornerRadius(24)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
            }
        }
    }
}


#Preview {
    WhaleAndDiverView()
}
