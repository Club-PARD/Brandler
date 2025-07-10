
import SwiftUI

struct EditInfoView: View {
    @EnvironmentObject var session: UserSessionManager
    @State private var nickname: String = ""
    @State private var selectedGenre: String = ""
    @Environment(\.dismiss) var dismiss
    @Binding var currentState: AppState

    // Genre list
    let genres = [
        ["아메카지", "스트릿", "히피", "빈티지"],
        ["포멀", "페미닌", "캐주얼", "테크웨어"],
        ["기타"]
    ]

    // Initialize nickname and genre from session
    func loadUserInfo() {
        if let user = session.userData {
            nickname = user.nickname
            selectedGenre = user.fashionGenre
        }
    }

    var body: some View {
        ZStack {
            Color.BgColor.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    // Back Button
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(Color(white: 0.9))
                            .padding(.leading, 6)
                    }

                    Spacer()

                    // Title
                    Text("설정")
                        .foregroundColor(Color.white)
                        .font(.custom("Pretendard-Bold",size: 15))

                    Spacer()

                    // Confirm Button
                    Button(action: {
                        if let email = session.userData?.email {
                            UserServerAPI.patchUserInfo(email: email, nickname: nickname, genre: selectedGenre) { success in
                                DispatchQueue.main.async {
                                    if success {
                                        // PATCH 성공 시 세션 정보도 업데이트
                                        session.saveUserData(email: email, nickname: nickname, genre: selectedGenre)
                                        dismiss()
                                    } else {
                                        // 실패 시 에러 알림 등 처리
                                        // 예: alert 띄우기
                                    }
                                }
                            }
                        }
                    }) {
                        Text("확인")
                            .foregroundColor(Color.NextButton)
                            .font(.custom("Pretendard-Medium",size: 15))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 18)
                .padding(.bottom, 40)

                // Nickname change
                Text("닉네임 변경")
                    .foregroundColor(.EditBox)
                    .font(.custom("Pretendard-Bold",size: 13))
                    .padding(.horizontal, 20)
                ZStack(alignment: .leading) {
                    if nickname.isEmpty {
                        Text("닉네임을 입력해주세요")
                            .foregroundColor(.semiGray)
                            .font(.custom("Pretendard-Medium",size: 15)).opacity(0.15)
                            .padding(.leading, 18)
                            .padding(.vertical, 20)
                    }
                    TextField("", text: $nickname)
                        .foregroundColor(.white)
                        .font(.custom("Pretendard-Medium",size: 17))
                        .padding(.horizontal, 18)
                        .padding(.vertical, 20)
                }
                .background(Color.nickBox)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.nickBoxStroke, lineWidth: 3.5)
                )
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .padding(.top, 8)

                Text("기존 닉네임 : \(session.userData?.nickname ?? "-")")
                    .foregroundColor(.EditBox)
                    .font(.custom("Pretendard-Medium",size: 12))
                    .padding(.horizontal, 22)
                    .padding(.top, 6)
                    .padding(.bottom, 36)

                // Genre change
                Text("장르 변경")
                    .foregroundColor(.EditBox)
                    .font(.custom("Pretendard-Medium",size: 13))
                    .padding(.horizontal, 20)
                    .padding(.bottom, 12)

                VStack(alignment: .leading, spacing: 14) {
                    ForEach(0..<genres.count, id: \.self) { row in
                        HStack(spacing: 16) {
                            ForEach(genres[row], id: \.self) { genre in
                                Button(action: {
                                    selectedGenre = genre
                                }) {
                                    Text(genre)
                                        .font(.custom("Pretendard-Medium",size: 12))
                                        .foregroundColor(selectedGenre == genre ? .white : .EditTxt)
                                        .frame(width: 78, height: 38)
                                        .background(
                                            selectedGenre == genre
                                            ? Color.FashBox
                                            : Color.myDarkGray
                                        )
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)

                Text("기존 장르 : \(session.userData?.fashionGenre ?? "-")")
                    .foregroundColor(.EditBox)
                    .font(.custom("Pretendard-Medium",size: 12))
                    .padding(.horizontal, 22)
                    .padding(.top, 10)

                Spacer() // content padding only; 로그아웃 버튼은 overlay로 이동

            }
            .padding(.bottom, 80) // Prevents content from going under the logout button

            // 로그아웃 버튼을 오버레이로 고정
            if session.userData != nil {
                VStack {
                    Spacer()
                    Button(action: {
                        session.logout()
                        currentState = .login
                    }) {
                        Text("로그아웃")
                            .underline()
                            .foregroundColor(.EditBox)
                            .font(.custom("Pretendard-Medium", size: 15))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(Color.BgColor.opacity(0.97))
                    }
                }
                .ignoresSafeArea(.keyboard) // Keeps button fixed even when keyboard is up
                .padding(.horizontal, 0)
                .padding(.bottom, 0)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
        }
        .onAppear {
            loadUserInfo()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    EditInfoView(currentState: .constant(.main))
        .environmentObject(UserSessionManager.shared)
}
