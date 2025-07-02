//
//  CreateProfileViewModel.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//

//
//  CreateProfileViewModel.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
class CreateProfileViewModel: ObservableObject {
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var phoneNumber = ""
    @Published var email = ""
    @Published var password = ""
    
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var profileSaveSuccess = false
    
    private let firestoreService = FirestoreService()
    
    var isContinueButtonDisabled: Bool {
        firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty
    }
    
    func createUserAndSaveProfile() async {
        isLoading = true
        errorMessage = nil
        
        do {
            // Step 1: Create Firebase Auth user
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            print("✅ User created with UID: \(authResult.user.uid)")
            
            // Step 2: Create user profile object
            let userProfile = User(
                id: authResult.user.uid,
                email: self.email,
                firstName: self.firstName,
                lastName: self.lastName,
                phoneNumber: self.phoneNumber
            )
            
            // Step 3: Save to Firestore
            try await firestoreService.saveUserProfile(user: userProfile)
            
            profileSaveSuccess = true
            print("✅ Profile saved successfully!")
            
        } catch let error as NSError {
            handleFirebaseError(error)
        }
        
        isLoading = false
    }
    
    func saveProfile() async {
        isLoading = true
        errorMessage = nil
        
        guard let currentUser = Auth.auth().currentUser else {
            errorMessage = "No authenticated user found. Please sign in first."
            isLoading = false
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
            profileSaveSuccess = true
            print("✅ Profile saved successfully!")
        } catch let error as NSError {
            handleFirebaseError(error)
        }
        
        isLoading = false
    }
    
    private func handleFirebaseError(_ error: NSError) {
        print("❌ Firebase Error: \(error.localizedDescription)")
        print("Error Code: \(error.code)")
        print("Error Domain: \(error.domain)")
        
        if error.domain == AuthErrorDomain {
            switch AuthErrorCode(rawValue: error.code) {
            case .emailAlreadyInUse:
                errorMessage = "This email is already registered."
            case .invalidEmail:
                errorMessage = "Please enter a valid email address."
            case .weakPassword:
                errorMessage = "Password should be at least 6 characters."
            case .networkError:
                errorMessage = "Network error. Please check your connection."
            case .userNotFound:
                errorMessage = "User not found."
            case .wrongPassword:
                errorMessage = "Incorrect password."
            default:
                errorMessage = "Authentication error: \(error.localizedDescription)"
            }
        } else {
            errorMessage = "Could not save profile: \(error.localizedDescription)"
        }
    }
}
