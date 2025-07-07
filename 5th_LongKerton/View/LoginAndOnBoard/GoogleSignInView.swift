
import SwiftUI
import GoogleSignIn

struct GoogleSignInView: UIViewControllerRepresentable {
    let completion: (Bool, String?) -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        DispatchQueue.main.async {
            let rootVC = controller.view.window?.rootViewController
                ?? UIApplication.shared.connectedScenes
                    .compactMap { ($0 as? UIWindowScene)?.keyWindow }
                    .first?.rootViewController
            if let rootVC = rootVC {
                GIDSignIn.sharedInstance.signIn(withPresenting: rootVC) { result, error in
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
                    completion(true, email)
                }
            } else {
                completion(false, nil)
            }
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
