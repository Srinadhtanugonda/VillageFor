//
//  AuthenticationService.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//

import Foundation
import FirebaseAuth

class AuthenticationService {
    
    // A function to handle the creation of a new user account
    // using modern Swift concurrency (async/await).
    func signUp(withEmail email: String, password: String) async throws -> User {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let firebaseUser = authResult.user
            
            // Here you would typically save additional user details (like a name)
            // to another database like Firestore. For now, we'll just return
            // the basic user object from the authentication result.
            return User(id: firebaseUser.uid, email: firebaseUser.email ?? "")
            
        } catch {
            // The error from Firebase will be passed up to the ViewModel
            // to be displayed to the user.
            throw error
        }
    }
    
    // You would add other functions here like signIn, signOut, passwordReset, etc.
}
