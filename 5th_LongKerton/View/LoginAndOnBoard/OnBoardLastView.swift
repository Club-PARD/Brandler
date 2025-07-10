
import SwiftUI

struct OnBoardLastView: View {
    let finish: () -> Void
    let nickname: String
    let selectedGenre: String
    var currentStep: Int = 2 // 0, 1, 2 중 현재 단계

    @EnvironmentObject var session: UserSessionManager
    @State private var isUploading = false
    @State private var showError = false

    // 애니메이션 배경 관련 상태 및 상수
    @State private var offset: CGFloat = 0
    let imageWidth: CGFloat = 678 // height 240 기준 원본 비율
    let imageHeight: CGFloat = 240
    let animationDuration: Double = 10

    var body: some View {
        ZStack {
            Color.BgColor.ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer().frame(height: 30)
                
                // 진행 바
                HStack(spacing: 8) {
                    ForEach(0..<3) { idx in
                        Circle()
                            .fill(idx == currentStep ? Color.barBlue : Color.barBlack)
                            .frame(width: 10, height: 10)
                    }
                }
                .frame(height: 56)
                .padding(.horizontal, 16)
                .padding(.bottom, 35)
                
                // 환영 메시지
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("새로운 브랜드를 찾아 떠나는 탐험,")
                            .font(.custom("Pretendard-Regular",size: 22))
                            .foregroundColor(.NickWhite)
                        Text("디깅러가 되신 걸 환영해요!")
                            .font(.custom("Pretendard-Regular",size: 22))
                            .foregroundColor(.NickWhite)
                    }
                    Spacer()
                }
                .padding(.leading, 24)
                .padding(.bottom, 75)
                
                // 캐릭터 이미지 + 움직이는 배경
                ZStack {
                    GeometryReader { geometry in
                        let repeats = 3 // Seamless looping

                        HStack(spacing: 0) {
                            ForEach(0..<repeats, id: \.self) { _ in
                                Image("backgroundImage")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: imageWidth, height: imageHeight)
                                    .clipped()
                            }
                        }
                        .offset(x: offset)
                        .frame(width: geometry.size.width, height: imageHeight)
                        .onAppear {
                            animateRight(imageWidth: imageWidth)
                        }
                    }
                    .frame(width: imageWidth, height: imageHeight)
                    .clipped()
                    
                    Image("charWithCir")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 240)
                        .padding(.leading, 55)
                        .padding(.bottom, 20)
                }
                .frame(height: imageHeight)
                
                Spacer()
                
                // 설명 텍스트
                VStack(alignment: .center, spacing: 8) {
                    (
                        Text("좋아하는 브랜드를 발견하고 모으는 사람.\n그걸 우리는 ")
                        + Text("'디깅러'").font(.custom("Pretendard-Bold",size: 16)).foregroundColor(.white)
                        + Text("라고 부릅니다.\n - \n이제, 디깅을 시작할 시간이에요. 🌊")
                    )
                    .font(.custom("Pretendard-SemiBold",size: 16))
                    .foregroundColor(.lastTxt)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                }

                Spacer()
                    .padding(.leading, 24)
                    .padding(.bottom, 20)
                
                // 완료 버튼
                Button(action: {
                    guard let email = session.userData?.email, !nickname.isEmpty, !selectedGenre.isEmpty else {
                        showError = true
                        return
                    }
                    isUploading = true
                    UserServerAPI.uploadUserInfo(
                        name: nickname,
                        email: email,
                        genre: selectedGenre
                    ) { success in
                        DispatchQueue.main.async {
                            isUploading = false
                            if success {
                                session.saveUserData(email: email, nickname: nickname, genre: selectedGenre)
                                finish()
                            } else {
                                showError = true
                            }
                        }
                    }
                }) {
                    if isUploading {
                        ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 80)
                            .background(Color.lastBox)
                            .cornerRadius(40)
                    } else {
                        Text("디깅 시작하기")
                            .font(.custom("Pretend-SemiBold",size: 16))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 80)
                            .background(Color.lastBox)
                            .cornerRadius(100)
                    }
                }
                .padding(.horizontal, 25)
                .disabled(isUploading)
                .alert(isPresented: $showError) {
                    Alert(title: Text("오류"), message: Text("유저 정보 업로드에 실패했습니다.\n네트워크 상태를 확인해주세요."), dismissButton: .default(Text("확인")))
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }

    // 애니메이션 함수
    func animateRight(imageWidth: CGFloat) {
        withAnimation(Animation.linear(duration: animationDuration)) {
            offset = -imageWidth
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            offset = 0
            animateRight(imageWidth: imageWidth)
        }
    }
}

// 프리뷰
#Preview {
    OnBoardLastView(
        finish: {},
        nickname: "샘플닉네임",
        selectedGenre: "스트릿",
        currentStep: 2
    )
    .environmentObject(UserSessionManager.shared)
}
