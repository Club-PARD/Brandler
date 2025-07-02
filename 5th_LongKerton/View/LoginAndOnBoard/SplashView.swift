import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack{
            VStack {
                Spacer()
                
                // 로고 겸 브랜드명 (회색 박스)
                Text("로고 겸\n브랜드명")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .frame(width: 180, height: 80)
                    .background(Color(white: 0.9))
                    .cornerRadius(8)
                    .foregroundColor(.black)
                    .padding(.bottom, 24)
                
                // 서비스 한줄 소개 (회색 박스)
                Text("서비스 한줄 소개")
                    .font(.headline)
                    .frame(width: 240, height: 44)
                    .background(Color(white: 0.9))
                    .cornerRadius(8)
                    .foregroundColor(.black)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white.ignoresSafeArea())
        }
        
    }
}

#Preview {
    SplashView()
}
