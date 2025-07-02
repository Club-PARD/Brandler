
import SwiftUI

struct EditInfoView: View {
    @EnvironmentObject var session: UserSessionManager
    @State private var nickname: String = ""
    @State private var selectedGenre: String = ""
    
    // Genre list
    let genres = [
        ["아메카지", "펑크", "스트릿", "빈티지"],
        ["히피", "포멀", "페미닌", "테크"]
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
                // Top bar
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                    Text("설정")
                        .foregroundColor(.LogBlue)
                        .font(.system(size: 18, weight: .medium))
                    Spacer()
                    Button(action: {
                        // Save changes to session
                        session.saveUserData(nickname: nickname, genre: selectedGenre)
                    }) {
                        Text("확인")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 18)
                .padding(.bottom, 40)
                
                // Nickname change
                Text("닉네임 변경")
                    .foregroundColor(.LogBlue)
                    .font(.system(size: 15, weight: .medium))
                    .padding(.horizontal, 20)
                ZStack(alignment: .leading) {
                    if nickname.isEmpty {
                        Text("닉네임을 입력해주세요")
                            .foregroundColor(.white.opacity(0.2))
                            .font(.system(size: 17))
                            .padding(.leading, 18)
                    }
                    TextField("", text: $nickname)
                        .foregroundColor(.white)
                        .font(.system(size: 17))
                        .padding(.horizontal, 18)
                        .padding(.vertical, 18)
                }
                .background(Color(red: 0.12, green: 0.13, blue: 0.16))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white.opacity(0.15), lineWidth: 1)
                )
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.top, 8)
                
                Text("기존 닉네임: \(session.userData?.nickname ?? "-")")
                    .foregroundColor(.white.opacity(0.7))
                    .font(.system(size: 13))
                    .padding(.horizontal, 22)
                    .padding(.top, 6)
                    .padding(.bottom, 30)
                
                // Genre change
                Text("장르 변경")
                    .foregroundColor(.LogBlue)
                    .font(.system(size: 15, weight: .medium))
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
                                        .font(.system(size: 15, weight: .medium))
                                        .foregroundColor(selectedGenre == genre ? .white : .LogBlue)
                                        .frame(width: 78, height: 38)
                                        .background(
                                            selectedGenre == genre
                                            ? Color.barBlue
                                            : Color.EditBox
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 18)
                                                .stroke(selectedGenre == genre ? Color.LogBlue : Color.LogBlue.opacity(0.3), lineWidth: 1.5)
                                        )
                                        .cornerRadius(18)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Text("기존 장르: \(session.userData?.fashionGenre ?? "-")")
                    .foregroundColor(.white.opacity(0.7))
                    .font(.system(size: 13))
                    .padding(.horizontal, 22)
                    .padding(.top, 10)
                
                Spacer()
                
                //forexampel
                VStack{
                    if let userData = session.userData {
                        
                        Text("환영합니다, \(userData.nickname)님!")
                        Text("선호 장르: \(userData.fashionGenre)")
                        Button("Reset Data (Logout)") {
                            session.logout()
                            
                                    }
                    
                    }
                    
                }
                .foregroundColor(.LogBlue)
                .font(.system(size: 15, weight: .medium))
                .padding(.horizontal, 20)
                
                
                //forexmaple
            }
        }
        .onAppear {
            loadUserInfo()
        }
    }
}

#Preview {
    EditInfoView()
        .environmentObject(UserSessionManager.shared)
}

