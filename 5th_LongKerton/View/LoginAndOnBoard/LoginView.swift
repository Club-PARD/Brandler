
import SwiftUI

struct LoginView: View {
    let goToNext: () -> Void
    @EnvironmentObject var session: UserSessionManager
    @Binding var appState: AppState
    
    var body: some View {
        ZStack(alignment: .bottom){
            Color.BgColor.ignoresSafeArea()
            VStack {
                VStack(spacing: 16) { // spacing 값으로 간격 조절
                    Image("brandler")
                        .resizable()
                        .frame(width: 250, height: 90)
                        .cornerRadius(8)

                    (
                        Text("패션 러버들을 위한 ") +
                        Text("브랜드 디깅 플랫폼").bold() +
                        Text(", 브랜들러")
                    )
                    .foregroundColor(.white)
                    .font(.system(size: 13))
                }
                .frame(maxHeight: .infinity, alignment: .center) // 세로 중앙 정렬
                
            
            }
            HStack {
                Spacer()
                Button(action: {
                    if session.isLoggedIn {
                        goToMain()
                    } else {
                        goToNext()
                    }
                }) {
                    HStack {
                        Image(systemName: "applelogo")
                            .font(.title2)
                            .padding(.horizontal, 20)
                        Spacer()
                        Text("Apple로 시작하기")
                            .font(.body)
                            .fontWeight(.medium)
                            .padding(.trailing, 110)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .background(Color.black)
                    .cornerRadius(10)
                }
                Spacer().frame(width: 16)
            }
            Spacer()

        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if session.isLoggedIn {
                goToMain()
            }
        }
    }
    
    private func goToMain() {
        DispatchQueue.main.async {
            appState = .main
        }
    }
}

#Preview {
    LoginView(goToNext: {}, appState: .constant(.onboarding))
        .environmentObject(UserSessionManager.shared)
}




