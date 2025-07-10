
import SwiftUI
import GoogleSignIn

enum AppState {
    case splash
    case login
    case onboarding
    case main
}

struct ContentView: View {
    @State private var currentState: AppState = .splash
    @StateObject private var session = UserSessionManager.shared
    
    
    var body: some View {
        ZStack{
            Color.BgColor
                .ignoresSafeArea()
            Group{
                switch currentState{
                case .splash:
                    SplashView(currentState: $currentState)
                case .login:
                    LoginView(currentState: $currentState)
                case .onboarding:
                    OnboardingFlowView(currentState: $currentState)
                case .main:
                    KDView(currentState: $currentState)
                }
            }
            .environmentObject(session)
            .transition(.opacity)
        }
        .animation(.easeInOut(duration: 0.3), value: currentState)
    }
}
    



#Preview {
    ContentView()
        .environmentObject(UserSessionManager.shared)
}
