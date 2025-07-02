import SwiftUI

struct MainView: View {
    @EnvironmentObject var session: UserSessionManager
    
    var body: some View {
        VStack {
            if let userData = session.userData {
                Text("환영합니다, \(userData.nickname)님!")
                Text("선호 장르: \(userData.fashionGenre)")
                Button("Reset Data (Logout)") {
                    session.logout()
                    
                            }
            } else {
                Text("bye")
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(UserSessionManager.shared)
}
