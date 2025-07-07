//
//  _th_LongKertonApp.swift
//  5th_LongKerton
//
//  Created by Kim Kyengdong on 6/22/25.
//

//import SwiftUI
//
//@main
//struct _th_LongKertonApp: App {
//    var body: some Scene {
//        WindowGroup {
//           ContentView()
//        }
//    }
//}

import SwiftUI
import GoogleSignIn

@main
struct _th_LongKertonApp: App {
    // Add this to connect AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserSessionManager.shared)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
