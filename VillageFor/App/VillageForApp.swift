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
    
    @StateObject private var mainViewModel = MainViewModel()
    @StateObject private var sessionManager = SessionManager() // 1. Create the session manager
    
    var body: some Scene {
        WindowGroup {
            // 2. The app now checks for a logged-in user AND if onboarding is complete.
            if mainViewModel.currentUser != nil && sessionManager.isOnboardingComplete {
                // This is the main part of your app. We'll create a placeholder for now.
                Text("Home Screen!")
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
