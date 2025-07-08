//
//  SessionManager.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//


import Foundation
import FirebaseAuth
import Combine

// This object will be shared across the app to manage the session state.
class SessionManager: ObservableObject {
    
    // When this becomes true, the app will switch from the sign-up flow
    // to the main home screen.
    @Published var isOnboardingComplete = false
    @Published var currentUser: User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupFirebaseAuthListener()
    }
    
    private func setupFirebaseAuthListener() {
        // This listener fires whenever the user logs in or out
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            
            if let firebaseUser = user {
                // User is logged in, fetch their profile
                Task {
                    await self.fetchCurrentUserProfile(uid: firebaseUser.uid)
                }
            } else {
                // User is logged out, clear all session data
                self.currentUser = nil
                self.isOnboardingComplete = false
            }
        }
    }
    
    private let firestoreService = FirestoreService()
    
    // A function to fetch the user's profile from the database.
    func fetchCurrentUserProfile(uid: String) async {
        do {
            self.currentUser = try await firestoreService.fetchUserProfile(uid: uid)
            // If we successfully fetched a profile with a first name, onboarding is complete
//            if self.currentUser?.firstName != nil {
//                self.isOnboardingComplete = true
//            }
        } catch {
            print("Error fetching user profile: \(error.localizedDescription)")
            self.currentUser = nil
            self.isOnboardingComplete = false
        }
    }
}
