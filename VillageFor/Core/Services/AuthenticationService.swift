//
//  AuthenticationService.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore 

class AuthenticationService {
    
    private let usersCollection = Firestore.firestore().collection("users")

    
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
    
    // we need to add other functions here like signIn, signOut, passwordReset, etc.
    
    func signIn(withEmail email: String, password: String) async throws -> User {
           // 1. Sign in the user with Firebase Authentication
           let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
           let uid = authResult.user.uid
           
           // 2. Fetch the user's profile document from Firestore
           let snapshot = try await usersCollection.document(uid).getDocument()
           
           // 3. Decode the document into our User model
           let user = try snapshot.data(as: User.self)
           
           // 4. Return the complete user object
           return user
       }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
