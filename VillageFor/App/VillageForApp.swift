//
//  VillageForApp.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//

import SwiftUI
import FirebaseCore

// This AppDelegate is needed to configure Firebase when the app launches
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct VillageForApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var sessionManager = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            // 2. we now checks for a logged-in user AND if onboarding is complete.
            if sessionManager.isOnboardingComplete, let user = sessionManager.currentUser {
                // Navigation to homepage landing of our app, passing currentUser object.
                HomeView(user: user).environmentObject(sessionManager)
            } else {
                // The authentication flow
                WelcomeView()
                    // 3. Inject the session manager into the environment
                    // so nested views (like CreateProfileView) can access it.
                    .environmentObject(sessionManager)
            }
        }
    }
}
