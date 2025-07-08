

import SwiftUI
import GoogleSignIn

struct LoginView: View {
    @Binding var currentState: AppState
    @EnvironmentObject var session: UserSessionManager

    @State private var showGoogleSheet = false

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.BgColor.ignoresSafeArea()
            VStack {
                VStack(spacing: 16) {
                    Image("brandler")
                        .resizable()
                        .frame(width: 250, height: 90)
                        .cornerRadius(8)
                    (
                        Text("패션 러버들을 위한 ") +
                        Text("브랜드 디깅 플랫폼")
                            .font(.custom("Pretendard-Bold", size: 13)) +
                        Text(", 브랜들러")
                    )
                    .foregroundColor(.white)
                    .font(.custom("Pretendard-Medium",size: 13))
                }
                .frame(maxHeight: .infinity, alignment: .center)
            }

            VStack(spacing: 12) {
                // Google 로그인 버튼
                Button(action: {
                    showGoogleSheet = true
                }) {
                    HStack {
                        Image("googleLogo")
                            .font(.title2)
                            .padding(.horizontal, 30)
                        Spacer()
                        Text("Google로 로그인")
                            .font(.custom("Pretendard-SemiBold",size: 16))
                            .foregroundColor(.black)
                            .padding(.trailing, 110)
                    }
                    .frame(maxWidth: .infinity, minHeight: 70)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                }
                .sheet(isPresented: $showGoogleSheet) {
                    GoogleSignInView { success, email in
                        showGoogleSheet = false
                        if success {
                            // 온보딩 정보가 있으면 바로 메인, 없으면 온보딩
                            if let userData = session.userData,
                               !userData.nickname.isEmpty,
                               !userData.fashionGenre.isEmpty {
                                goToMain()
                            } else {
                                goToOnboarding()
                            }
                        }
                    }
                }
            }
            .padding(.bottom, 24)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            // 이미 로그인 & 온보딩 정보가 있으면 바로 메인
            if session.isLoggedIn,
               let userData = session.userData,
               !userData.nickname.isEmpty,
               !userData.fashionGenre.isEmpty {
                goToMain()
            }
        }
    }

    private func goToMain() {
        DispatchQueue.main.async {
            currentState = .main
        }
    }

    private func goToOnboarding() {
        DispatchQueue.main.async {
            currentState = .onboarding
        }
    }
}


#Preview{
    LoginView(currentState: .constant(.login))
        .environmentObject(UserSessionManager.shared)
}
