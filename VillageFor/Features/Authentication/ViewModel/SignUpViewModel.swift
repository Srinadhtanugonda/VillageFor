//
//  SignUpViewModel.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//

import Foundation
import Combine

@MainActor // Ensures UI-related updates are on the main thread
class SignUpViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var registrationSuccessful = false

    
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let authService = AuthenticationService()
    
    func signUp() async {
        isLoading = true
        errorMessage = nil
        
        // Basic validation
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields."
            isLoading = false
            return
        }
        
        do {
            let user = try await authService.signUp(withEmail: email, password: password)
            print("Successfully signed up user: \(user.id)")
            // After successful sign-up, the `MainViewModel`'s listener will
            // automatically detect the new user and switch the view.
            registrationSuccessful = true 
        } catch {
            errorMessage = error.localizedDescription
            print("Error signing up: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
}
