import Foundation
import Combine

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
        var nickname: String
        var fashionGenre: String
    }
    
    private let userDataKey = "userData"
    
    private init() {
        // 로그인 상태 복원
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        // 사용자 데이터 복원
        if let savedData = UserDefaults.standard.data(forKey: userDataKey),
           let decoded = try? JSONDecoder().decode(UserData.self, from: savedData) {
            self.userData = decoded
        } else {
            self.userData = nil
        }
    }
    
    func saveUserData(nickname: String, genre: String) {
        let data = UserData(nickname: nickname, fashionGenre: genre)
        self.userData = data
        self.isLoggedIn = true
    }
    
    private func saveUserDataToUserDefaults() {
        guard let userData = userData else { return }
        if let encoded = try? JSONEncoder().encode(userData) {
            UserDefaults.standard.set(encoded, forKey: userDataKey)
        }
    }
    
    func logout() {
        isLoggedIn = false
        userData = nil
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: userDataKey)
    }
}
