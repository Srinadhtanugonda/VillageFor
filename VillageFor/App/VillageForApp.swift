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
            if ProcessInfo.processInfo.arguments.contains("-debugBypassLogin") {
                // If we are in debug mode, show the main tabs immediately
                // with a sample user.
                MainTabView()
                    .onAppear {
                        // We manually set the session manager's user for debug purposes
                        sessionManager.currentUser = MockData.sampleUser
                    }
                    .environmentObject(sessionManager)
                
            }
            //we now check for a logged-in user AND if onboarding is complete.
            else if sessionManager.isOnboardingComplete, sessionManager.currentUser != nil {
                // Navigation to homepage landing of our app, passing currentUser object.
                MainTabView().environmentObject(sessionManager)
            } else {
                //authentication flow
                WelcomeView()
                //Injecting the session manager into the environment
                    .environmentObject(sessionManager)
            }
            
        }
    }
}

// By placing MockData inside an #if DEBUG block, it will only be available
// during development and will not be included in your final app.
#if DEBUG
struct MockData {
    static let sampleUser = User(
        id: "debug_user_123",
        email: "Srinadh@debug.com",
        firstName: "Sri",
        lastName: "",
        age: 26
    )
}
#endif
