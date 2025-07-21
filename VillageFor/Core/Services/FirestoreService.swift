//
//  FirestoreService.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//


import Foundation
import FirebaseFirestore

class FirestoreService: FirestoreServiceProtocol {

    
    func saveUserConsent(agreedToHealthData: Bool, agreedToTerms: Bool) async throws {
        print("need to get an update from christy regarding the placement of this screen")
    }
    
    
    // Get a reference to the 'users' collection in Firestore
    private let usersCollection = Firestore.firestore().collection("users")

    private func userDocument(uid: String) -> DocumentReference {
           return usersCollection.document(uid)
       }
    
    // Saves the user's profile data to Firestore
    func saveUserProfile(user: User) async throws {
        // We use the user's unique ID (from Firebase Auth) as the document ID
        // This links the auth user to their database record.
        // The `Codable` conformance on our User model lets us do this easily.
        try await userDocument(uid: user.id).setData(from: user, merge: true)
    }
    
    /// Updates the age for a specific user in Firestore.
      func updateUserAge(uid: String, age: Int) async throws {
          // Use updateData to change only specific fields of a document
          // without overwriting the whole thing.
          try await usersCollection.document(uid).updateData(["age": age])
      }
    
    func updateUserPreferences(uid: String, preferences: NotificationPreferences) async throws {
        // We need to convert the struct to a dictionary to save it
        let data = [
            "moodCheckins": preferences.moodCheckins,
            "epdsAssessments": preferences.epdsAssessments,
            "dailyAffirmations": preferences.dailyAffirmations
        ]
        try await userDocument(uid: uid).updateData(["notificationPreferences": data])
    }
    
    func fetchUserProfile(uid: String) async throws -> User? {
        let snapshot = try await usersCollection.document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    //MARK: Daily mood checkin.
    
    func saveDailyCheckin(uid: String, checkin: DailyCheckin) async throws {
        // This creates a new document in a "dailyCheckins" subcollection for the user.
        try userDocument(uid: uid).collection("dailyCheckins").addDocument(from: checkin)
    }
    
    func fetchLatestCheckin(uid: String) async throws -> DailyCheckin? {
        let snapshot = try await userDocument(uid: uid)
            .collection("dailyCheckins")
            // Order the results by timestamp, with the newest first
            .order(by: "timestamp", descending: true)
            // We only need the single most recent document
            .limit(to: 1)
            .getDocuments()
        
        // Safely decode and return the first document found, or nil if none exist.
        return snapshot.documents.compactMap { doc in
            try? doc.data(as: DailyCheckin.self)
        }.first
    }
}
