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
            //we now check for a logged-in user AND if onboarding is complete.
            if sessionManager.isOnboardingComplete, let user = sessionManager.currentUser {
                // Navigation to homepage landing of our app, passing currentUser object.
                MainTabView(user: user).environmentObject(sessionManager) 
            } else {
                //authentication flow
                WelcomeView()
                    //Injecting the session manager into the environment
                    .environmentObject(sessionManager)
            }
        }
    }
}
