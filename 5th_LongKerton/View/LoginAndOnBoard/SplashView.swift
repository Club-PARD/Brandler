
import SwiftUI

struct SplashView: View {
    @Binding var currentState: AppState
    @EnvironmentObject var session: UserSessionManager

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("로고 겸\n브랜드명")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .frame(width: 180, height: 80)
                    .background(Color(white: 0.9))
                    .cornerRadius(8)
                    .foregroundColor(.black)
                    .padding(.bottom, 24)
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    currentState = .onboarding
                }
            }
        }
    }
}

#Preview {
    SplashView(currentState: .constant(.splash))
        .environmentObject(UserSessionManager.shared)
}


