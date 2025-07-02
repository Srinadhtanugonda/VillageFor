import Foundation

// This object will be shared across the app to manage the session state.
class SessionManager: ObservableObject {
    
    // When this becomes true, the app will switch from the sign-up flow
    // to the main home screen.
    @Published var isOnboardingComplete = false
}