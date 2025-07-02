import SwiftUI
/*
// 1. Enum for navigation steps
enum OnboardingStep: Hashable {
    case whaleAndDiver
    case nickName
    case chooseFashion
    case last
}


// 2. Main onboarding flow container
struct OnboardingFlowView: View {
    @State private var path = NavigationPath()
    @Environment(\.dismiss) private var dismiss  // Only needed if you want to dismiss onboarding at the end
    
    var body: some View {
        NavigationStack(path: $path) {
            LoginView(goToNext: {
                path.append(OnboardingStep.whaleAndDiver)
            })
            .navigationDestination(for: OnboardingStep.self) { step in
                switch step {
                case .whaleAndDiver:
                    WhaleAndDiverView(goToNext: {
                        path.append(OnboardingStep.nickName)
                    })
                case .nickName:
                    OnBoardNickNameView(goToNext: {
                        path.append(OnboardingStep.chooseFashion)
                    })
                case .chooseFashion:
                    OnBoardChooseFashionView(goToNext: {
                        path.append(OnboardingStep.last)
                    })
                case .last:
                    OnBoardLastView(finish: {
                        // Example: Dismiss or transition to main app
                        dismiss()
                    })
                }
            }
        }
    }
}
*/
// OnboardingFlowView.swift

enum OnboardingStep: Hashable {
    case whaleAndDiver
    case nickName
    case chooseFashion
    case last
}

struct OnboardingFlowView: View {
    @Binding var currentState: AppState
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            LoginView(goToNext: {
                path.append(OnboardingStep.whaleAndDiver)
            })
            .navigationDestination(for: OnboardingStep.self) { step in
                switch step {
                case .whaleAndDiver:
                    WhaleAndDiverView(goToNext: {
                        path.append(OnboardingStep.nickName)
                    })
                case .nickName:
                    OnBoardNickNameView(goToNext: {
                        path.append(OnboardingStep.chooseFashion)
                    })
                case .chooseFashion:
                    OnBoardChooseFashionView(goToNext: {
                        path.append(OnboardingStep.last)
                    })
                case .last:
                    OnBoardLastView(finish: {
                        withAnimation {
                            currentState = .main
                        }
                    })
                }
            }
        }
    }
}

#Preview {
    OnboardingFlowView(currentState: .constant(.onboarding))
}

//#Preview {
  //  OnboardingFlowView()
//}
