//
//import SwiftUI
//
//struct LoginView: View {
//    let goToNext: () -> Void
//    @EnvironmentObject var session: UserSessionManager
//    @Binding var appState: AppState
//    
//    var body: some View {
//        ZStack(alignment: .bottom){
//            Color.BgColor.ignoresSafeArea()
//            VStack {
//                VStack(spacing: 16) { // spacing 값으로 간격 조절
//                    Image("brandler")
//                        .resizable()
//                        .frame(width: 250, height: 90)
//                        .cornerRadius(8)
//
//                    (
//                        Text("패션 러버들을 위한 ") +
//                        Text("브랜드 디깅 플랫폼").bold() +
//                        Text(", 브랜들러")
//                    )
//                    .foregroundColor(.white)
//                    .font(.system(size: 13))
//                }
//                .frame(maxHeight: .infinity, alignment: .center) // 세로 중앙 정렬
//                
//            
//            }
//            
//            HStack {
//                Button(action: {
//                    if session.isLoggedIn {
//                        goToMain()
//                    } else {
//                        goToNext()
//                    }
//                }) {
//                    HStack {
//                        Image("kakaoLogo")
//                            .font(.title2)
//                            .padding(.horizontal, 20)
//                        Spacer()
//                        Text("카카오로 3초 만에 로그인")
//                            .font(.body)
//                            .fontWeight(.medium)
//                            .padding(.trailing, 85)
//                    }
//                    .foregroundColor(.black)
//                    .frame(maxWidth: .infinity, minHeight: 70)
//                    .background(Color.Kakao)
//                    .cornerRadius(10)
//                    .padding(.horizontal, 16)
//                    .padding(.bottom, 12)
//                }
//            }
//            Spacer()
//
//        }
//        .navigationBarBackButtonHidden(true)
//        .onAppear {
//            if session.isLoggedIn {
//                goToMain()
//            }
//        }
//    }
//    
//    private func goToMain() {
//        DispatchQueue.main.async {
//            appState = .main
//        }
//    }
//}
//
//#Preview {
//    LoginView(goToNext: {}, appState: .constant(.onboarding))
//        .environmentObject(UserSessionManager.shared)
//}
//
//
//

import SwiftUI

struct LoginView: View {
    let goToNext: () -> Void
    @EnvironmentObject var session: UserSessionManager
    @Binding var appState: AppState
    
    var body: some View {
        ZStack(alignment: .bottom){
            Color.BgColor.ignoresSafeArea()
            VStack {
                VStack(spacing: 16) {
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
                .frame(maxHeight: .infinity, alignment: .center)
            }
            
            VStack(spacing: 12) {
                // Google 로그인 버튼
                Button(action: {
                    // Google 로그인 액션 구현
                }) {
                    HStack {
                        Image("googleLogo")
                            .font(.title2)
                            .padding(.horizontal, 20)
                        Spacer()
                        Text("Google로 로그인")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .padding(.trailing, 110)
                    }
                    .frame(maxWidth: .infinity, minHeight: 70)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                }
                
                // 카카오 로그인 버튼
                Button(action: {
                    if session.isLoggedIn {
                        goToMain()
                    } else {
                        goToNext()
                    }
                }) {
                    HStack {
                        Image("kakaoLogo")
                            .font(.title2)
                            .padding(.horizontal, 20)
                        Spacer()
                        Text("카카오로 3초 만에 로그인")
                            .font(.body)
                            .fontWeight(.medium)
                            .padding(.trailing, 85)
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, minHeight: 70)
                    .background(Color.Kakao)
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                }
            }
            .padding(.bottom, 24)
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

