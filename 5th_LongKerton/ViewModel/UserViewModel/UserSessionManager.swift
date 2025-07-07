
import Foundation
import Combine
import GoogleSignIn

class UserSessionManager: ObservableObject {
    static let shared = UserSessionManager()
    
    @Published var isLoggedIn: Bool {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        }
    }
    
    @Published var userData: UserData? {
        didSet {
            saveUserDataToUserDefaults()
        }
    }
    
    struct UserData: Codable {
        var email: String
        var nickname: String
        var fashionGenre: String
    }
    
    private let userDataKey = "userData"
    
    private init() {
        // UserDefaults에서 로그인 상태와 유저 정보 복원
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        if let savedData = UserDefaults.standard.data(forKey: userDataKey),
           let decoded = try? JSONDecoder().decode(UserData.self, from: savedData) {
            self.userData = decoded
        } else {
            self.userData = nil
        }
        
        // 앱 시작 시 구글 세션 복원
        GIDSignIn.sharedInstance.restorePreviousSignIn { [weak self] user, error in
            guard let self = self else { return }
            if let user = user {
                DispatchQueue.main.async {
                    let email = user.profile?.email ?? ""
                    let nickname = self.userData?.nickname ?? ""
                    let genre = self.userData?.fashionGenre ?? ""
                    self.saveUserData(email: email, nickname: nickname, genre: genre)
                    self.isLoggedIn = true
                }
            }
        }
    }
    
    // MARK: - 유저 데이터 저장
    func saveUserData(email: String, nickname: String, genre: String) {
        let data = UserData(email: email, nickname: nickname, fashionGenre: genre)
        self.userData = data
        self.isLoggedIn = true
    }
    
    private func saveUserDataToUserDefaults() {
        guard let userData = userData else { return }
        if let encoded = try? JSONEncoder().encode(userData) {
            UserDefaults.standard.set(encoded, forKey: userDataKey)
        }
    }
    
    // MARK: - Google 로그인
    func signInWithGoogle(presentingViewController: UIViewController, completion: @escaping (Bool, String?) -> Void) {
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
            if let error = error {
                print("Google Sign-In Error: \(error.localizedDescription)")
                completion(false, nil)
                return
            }
            guard let result = result,
                  let profile = result.user.profile else {
                completion(false, nil)
                return
            }
            let email = profile.email
            self.saveUserData(email: email, nickname: "", genre: "")
            completion(true, email)
        }
    }
    
    // MARK: - 온보딩 후 장르/닉네임 업데이트
    func updateNickname(_ nickname: String) {
        guard var currentUserData = userData else { return }
        currentUserData.nickname = nickname
        self.userData = currentUserData
    }
    
    func updateGenre(_ genre: String) {
        guard var currentUserData = userData else { return }
        currentUserData.fashionGenre = genre
        self.userData = currentUserData
    }
    
    // MARK: - 로그아웃
    func logout() {
        isLoggedIn = false
        userData = nil
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: userDataKey)
        GIDSignIn.sharedInstance.signOut()
    }

}
