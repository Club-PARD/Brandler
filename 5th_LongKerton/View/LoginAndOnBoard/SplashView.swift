

import SwiftUI

struct SplashView: View {
    @Binding var currentState: AppState
    @EnvironmentObject var session: UserSessionManager

    @State private var logo1Offset: CGFloat = -300
    @State private var logo3Offset: CGFloat = 300
    
    // 애니메이션 완료 후 이미지 변경을 위한 상태
    @State private var showFinalImage: Bool = false

    var body: some View {
        ZStack {
            Color.BgColor.ignoresSafeArea()
            VStack {
                Spacer()
                
                
                ZStack {
                    if showFinalImage {
                        VStack(spacing: 16) { // spacing 값으로 간격 조절
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
                        .frame(maxHeight: .infinity, alignment: .center) // 세로 중앙 정렬

                    } else {
                        // 애니메이션 중 원래 이미지들
                        Image("brandlerBlack")
                            .resizable()
                            .frame(width: 250, height: 90)
                            .padding(.bottom, 24)
                            .offset(y: logo1Offset)
                            .zIndex(0)

                        Image("brandlerPurple")
                            .resizable()
                            .frame(width: 250, height: 90)
                            .scaleEffect(1.05)
                            .padding(.bottom, 24)
                            .zIndex(1)

                        Image("brandlerGray")
                            .resizable()
                            .frame(width: 250, height: 90)
                            .padding(.bottom, 24)
                            .offset(y: logo3Offset)
                            .zIndex(0)
                    }
                }
                Spacer()

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            // 초기 위치 설정
            logo1Offset = -300
            logo3Offset = 300
            
            // 애니메이션 중앙으로 이동
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.easeOut(duration: 2)) {
                    logo1Offset = 0
                    logo3Offset = 0
                }
            }
            
            // 애니메이션 완료 후 이미지 변경
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    showFinalImage = true
                }
            }
            
            // 3초 후 화면 전환
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation {
                    currentState = .onboarding
                }
            }
        }
    }
}

#Preview {
    SplashView(currentState: .constant(.splash))
        .environmentObject(UserSessionManager.shared)
}
