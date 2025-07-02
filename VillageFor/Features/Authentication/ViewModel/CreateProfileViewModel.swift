import Foundation
import FirebaseAuth

@MainActor
class CreateProfileViewModel: ObservableObject {
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var phoneNumber = ""
    @Published var email = "" // This will be pre-populated
    
    @Published var registrationComplete = false
    @Published var errorMessage: String?
    
    private let firestoreService = FirestoreService()
    
    init() {
        // Pre-populate the email field from the currently logged-in user
        guard let currentUser = Auth.auth().currentUser else {
            self.email = "Not found"
            return
        }
        self.email = currentUser.email ?? "No email"
    }
    
    var isContinueButtonDisabled: Bool {
        firstName.isEmpty || lastName.isEmpty
    }
    
    func saveProfile() async {
        guard let currentUser = Auth.auth().currentUser else {
            errorMessage = "No authenticated user found."
            return
        }
        
        let userProfile = User(
            id: currentUser.uid,
            email: self.email,
            firstName: self.firstName,
            lastName: self.lastName,
            phoneNumber: self.phoneNumber
        )
        
        do {
            try await firestoreService.saveUserProfile(user: userProfile)
            print("Profile saved successfully!")
            registrationComplete = true // Signal to navigate to the main app
        } catch {
            errorMessage = "Could not save profile: \(error.localizedDescription)"
        }
    }
}