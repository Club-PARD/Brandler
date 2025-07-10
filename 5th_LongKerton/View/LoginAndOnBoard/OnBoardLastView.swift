import SwiftUI

// 움직이는 배경 뷰: charWithCir와 동일한 크기로 반복 애니메이션
struct MovingBackgroundView: View {
    @State private var offset: CGFloat = 0
    let imageHeight: CGFloat = 208
    let animationDuration: Double = 10

    var body: some View {
        GeometryReader { geometry in
            let imageWidth = geometry.size.width
            // 충분히 반복되도록 이미지 개수 계산
            let repeats = Int((imageWidth / imageHeight).rounded(.up)) + 1

            HStack(spacing: 0) {
                ForEach(0..<repeats, id: \.self) { _ in
                    Image("backgroundImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 605, height: imageHeight)
                        .clipped()
                }
            }
            .offset(x: offset)
            .frame(width: 605, height: imageHeight)
            .onAppear {
                animateRight(imageWidth: imageWidth)
            }
        }
        .frame(height: imageHeight)
        .clipped()
    }

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

struct OnBoardLastView: View {
    let finish: () -> Void
    let nickname: String
    let selectedGenre: String
    var currentStep: Int = 2 // 0, 1, 2 중 현재 단계

    @EnvironmentObject var session: UserSessionManager
    @State private var isUploading = false
    @State private var showError = false

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
                .padding(.horizontal, 16)
                .padding(.bottom, 62)
                .padding(.top, 62)
                
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
                    .kerning(-0.45)
                    .lineSpacing(4.8)
                    Spacer()
                }
                .padding(.leading, 24)
                .padding(.bottom, 66)
                
                // 캐릭터 이미지 + 움직이는 배경
                ZStack {
                    MovingBackgroundView()
                    Image("charWithCir")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 147.51, height: 208)
                        .padding(.leading, 55)
                }
                .padding(.bottom, 32)
                .padding(.top, 0)
                
                // 설명 텍스트
                VStack(alignment: .center, spacing: 8) {
                    Text("좋아하는 브랜드를 발견하고 모으는 사람.")
                        .font(.custom("Pretendard-SemiBold", size: 16))
                        .foregroundColor(.lastTxt)
                    HStack(spacing: 0) {
                        Text("우리는 그들을  ")
                            .font(.custom("Pretendard-SemiBold", size: 16))
                            .foregroundColor(.lastTxt)
                        Text("'디깅러'")
                            .font(.custom("Pretendard-Bold", size: 16))
                            .foregroundColor(.white)
                        Text("라고 부릅니다.")
                            .font(.custom("Pretendard-SemiBold", size: 16))
                            .foregroundColor(.lastTxt)
                    }
                    Text("-")
                        .font(.custom("Pretendard-SemiBold", size: 16))
                        .foregroundColor(.lastTxt)
                    HStack(spacing: 0) {
                        Text("브랜드를 발견할수록 디깅러는  ")
                            .font(.custom("Pretendard-SemiBold", size: 16))
                            .foregroundColor(.lastTxt)
                        Text("'5단계'")
                            .font(.custom("Pretendard-Bold", size: 16))
                            .foregroundColor(.white)
                        Text("로 성장해요.")
                            .font(.custom("Pretendard-SemiBold", size: 16))
                            .foregroundColor(.lastTxt)
                    }
                    Text("이제, 디깅을 시작할 시간이에요. 🌊")
                        .font(.custom("Pretendard-SemiBold", size: 16))
                        .foregroundColor(.lastTxt)
                }
                
                .kerning(-0.45)
                .lineSpacing(4.8)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.top, 0)
                .padding(.bottom, 80)
                
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
                            .font(.custom("Pretendard-SemiBold",size: 16))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 80)
                            .background(Color.lastBox)
                            .cornerRadius(100)
                    }
                }
                .padding(.horizontal, 25)
                .padding(.bottom, 6)
                .disabled(isUploading)
                .alert(isPresented: $showError) {
                    Alert(title: Text("오류"), message: Text("유저 정보 업로드에 실패했습니다.\n네트워크 상태를 확인해주세요."), dismissButton: .default(Text("확인")))
                }
            }
            .navigationBarBackButtonHidden(true)
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
