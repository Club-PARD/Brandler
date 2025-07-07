
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
    @State private var nickname: String = ""
    @State private var selectedGenre: String = ""

    var body: some View {
        NavigationStack(path: $path) {
            // 온보딩 첫 화면
            OnBoardNickNameView(
                goToNext: {
                    path.append(OnboardingStep.chooseFashion)
                },
                nickname: $nickname
            )
            .navigationDestination(for: OnboardingStep.self) { step in
                switch step {
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
                            if let email = session.userData?.email {
                                session.saveUserData(email: email, nickname: nickname, genre: selectedGenre)
                            }
                            // 온보딩 끝나면 LoginView로 돌아감
                            withAnimation {
                                currentState = .login
                            }
                        },
                        nickname: nickname,
                        selectedGenre: selectedGenre
                    )
                default: EmptyView()
                }
            }
        }
    }
}
