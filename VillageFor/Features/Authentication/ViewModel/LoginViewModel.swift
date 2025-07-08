//
//  LoginViewModel.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//

import Foundation

@MainActor
class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    // Properties to control navigation after login
    @Published var navigateToCreateProfile = false
    
    private let authService = AuthenticationService()
    
    var isLoginButtonDisabled: Bool {
        email.isEmpty || password.isEmpty
    }
    
    func login(sessionManager: SessionManager) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let user = try await authService.signIn(withEmail: email, password: password)
            print("Successfully logged in user: \(user.id)")
            
            // Check if the user has completed onboarding
            if user.firstName != nil {
                // If they have a first name, onboarding is complete.
                // The MainViewModel listener will handle showing the HomeView.
                sessionManager.isOnboardingComplete = true
            } else {
                // If not, we need to send them to the profile creation screen.
                navigateToCreateProfile = true
            }
            
        } catch {
            print("Error logging in: \(error.localizedDescription)")
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
