
import SwiftUI

enum AppState {
    case splash
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
        case .onboarding:
            OnboardingFlowView(currentState: $currentState)
                .environmentObject(session)
        case .main:
            UserMainView()
                .environmentObject(session)
        }
    }
}

#Preview {
    ContentView() 
}


