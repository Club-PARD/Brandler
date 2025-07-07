
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
        switch currentState {
        case .splash:
            SplashView(currentState: $currentState)
                .environmentObject(session)
        case .login:
            LoginView(currentState: $currentState)
                .environmentObject(session)
        case .onboarding:
            OnboardingFlowView(currentState: $currentState)
                .environmentObject(session)
        case .main:
            KDView()
                .environmentObject(session)
        }
        
    }
}

