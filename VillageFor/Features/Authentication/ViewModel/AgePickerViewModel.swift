//
//  AgePickerViewModel.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//

import Foundation
import SwiftUI
import FirebaseAuth // <-- Import FirebaseAuth

@MainActor
class AgePickerViewModel: ObservableObject {
    
    let ageRange = 18...100
    @Published var selectedAge: Int? = 34
    
    private let firestoreService = FirestoreService()
    
    func continueTapped(sessionManager: SessionManager) async {
        // Ensure we have a selected age and a logged-in user
        guard let age = selectedAge, let uid = Auth.auth().currentUser?.uid else {
            print("Error: No age selected or user not logged in.")
            return
        }
        
        do {
            // Try to update the user's age in the database
            try await firestoreService.updateUserAge(uid: uid, age: age)
            print("User age (\(age)) saved successfully.")
            
            // On success, complete the onboarding process
            sessionManager.isOnboardingComplete = true
            
        } catch {
            print("Error updating user age: \(error.localizedDescription)")
            // Optionally, show an error alert to the user
        }
    }
}
