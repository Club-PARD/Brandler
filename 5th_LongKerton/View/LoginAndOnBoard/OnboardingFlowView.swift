
import SwiftUI

enum OnboardingStep: Hashable {
    case nickName
    case chooseFashion
    case last
}

struct OnboardingFlowView: View {
    @Binding var currentState: AppState
    @EnvironmentObject var session: UserSessionManager
    @State private var path = NavigationPath()
    
    // 온보딩 데이터 상태
    @State private var nickname: String = ""
    @State private var selectedGenre: String = ""
    
    var body: some View {
        NavigationStack(path: $path) {
            // 항상 첫 화면은 LoginView
            LoginView(
                goToNext: {
                    // 온보딩 시작 (OnBoardNickNameView로 이동)
                    path.append(OnboardingStep.nickName)
                },
                appState: $currentState
            )
            .navigationDestination(for: OnboardingStep.self) { step in
                switch step {

                case .nickName:
                    OnBoardNickNameView(
                        goToNext: {
                            path.append(OnboardingStep.chooseFashion)
                        },
                        nickname: $nickname
                    )
                case .chooseFashion:
                    OnBoardChooseFashionView(
                        goToNext: {
                            path.append(OnboardingStep.last)
                        },
                        selectedGenre: $selectedGenre
                    )
                case .last:
                    OnBoardLastView(
                        finish: {
                            // 온보딩 데이터 저장
                            session.saveUserData(nickname: nickname, genre: selectedGenre)
                            // 온보딩 완료 후 다시 LoginView로 이동
                            withAnimation {
                                // path를 초기화하면 LoginView로 이동
                                path = NavigationPath()
                            }
                        },
                        nickname: nickname,
                        selectedGenre: selectedGenre
                    )
                }
            }
        }
    }
}

#Preview {
    OnboardingFlowView(currentState: .constant(.onboarding))
        .environmentObject(UserSessionManager.shared)
}

