//
//  FirestoreService.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//


import Foundation
import FirebaseFirestore

class FirestoreService {
    
    // Get a reference to the 'users' collection in Firestore
    private let usersCollection = Firestore.firestore().collection("users")
    
    // Saves the user's profile data to Firestore
    func saveUserProfile(user: User) async throws {
        // We use the user's unique ID (from Firebase Auth) as the document ID
        // This links the auth user to their database record.
        // The `Codable` conformance on our User model lets us do this easily.
        try usersCollection.document(user.id).setData(from: user, merge: true)
    }
    
    /// Updates the age for a specific user in Firestore.
      func updateUserAge(uid: String, age: Int) async throws {
          // Use updateData to change only specific fields of a document
          // without overwriting the whole thing.
          try await usersCollection.document(uid).updateData(["age": age])
      }
}
