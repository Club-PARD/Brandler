
import SwiftUI

struct LoginView: View {
    let goToNext: () -> Void
    @EnvironmentObject var session: UserSessionManager
    @Binding var appState: AppState
    
    var body: some View {
        ZStack{
            VStack {
                Spacer().frame(height: 180)
                VStack(alignment: .leading, spacing: 12) {
                    Text("고래")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(white: 0.9))
                        .cornerRadius(4)
                    Text("하나의 브랜드가 당신과 닿는 순간,\n취향은 이제 탐험이 아닌 연결이")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 36)
                Spacer().frame(height: 32)
                HStack {
                    Spacer().frame(width: 36)
                    Text("타이포 로고")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, minHeight: 120)
                        .background(Color(white: 0.9))
                        .cornerRadius(6)
                    Spacer().frame(width: 36)
                }
                Spacer().frame(height: 100)
                HStack {
                    Spacer().frame(width: 16)
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
            .background(Color.white.ignoresSafeArea())
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




