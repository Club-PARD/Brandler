
import SwiftUI
import GoogleSignIn

enum AppState {
    case splash
    case login
    case onboarding
    case main
    case search
    case history
    case brand
}

struct ContentView: View {
    @State private var currentState: AppState = .splash
    @State private var previousState: AppState = .splash
    @StateObject private var session = UserSessionManager.shared
    
    
    var body: some View {
        ZStack{
            Color.BgColor
                .ignoresSafeArea()
            Group {
                switch currentState {
                case .splash:
                    SplashView(currentState: $currentState)
                case .login:
                    LoginView(currentState: $currentState)
                case .onboarding:
                    OnboardingFlowView(currentState: $currentState)
                case .main:
                    KDView(currentState: $currentState, previousState: $previousState)
                case .search:
                    SearchView(currentState: $currentState, previousState: $previousState)
                case .history:
                    HistoryPage(currentState: $currentState, previousState: $previousState)
                case .brand:
                    BrandPage(currentState: $currentState, previousState: $previousState)

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
