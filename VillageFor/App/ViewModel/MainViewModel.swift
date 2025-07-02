//
//  MainViewModel.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//

import Foundation
import FirebaseAuth
import Combine

class MainViewModel: ObservableObject {
    
    @Published var currentUser: User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        // Listen for changes in Firebase's authentication state
        Auth.auth().addStateDidChangeListener { [weak self] _, firebaseUser in
            if let firebaseUser = firebaseUser {
                // User is signed in
                print("User is signed in with UID: \(firebaseUser.uid)")
                self?.currentUser = User(id: firebaseUser.uid, email: firebaseUser.email ?? "")
            } else {
                // User is signed out
                print("User is signed out.")
                self?.currentUser = nil
            }
        }
    }
}
