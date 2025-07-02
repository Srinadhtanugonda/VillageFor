import Foundation

@MainActor
class DataConsentViewModel: ObservableObject {
    
    @Published var agreesToHealthData = false
    @Published var agreesToTerms = false
    
    // A computed property to determine if the continue button should be enabled.
    var isContinueButtonDisabled: Bool {
        // It's disabled if either of the boxes is not checked.
        !agreesToHealthData || !agreesToTerms
    }
    
    func completeRegistration() {
        // Here, you would perform the final step, like marking the user's
        // profile as "onboarding_complete" in your database (e.g., Firestore).
        // After this, you would programmatically dismiss the auth flow.
        print("Registration complete! Navigating to main app...")
    }
}