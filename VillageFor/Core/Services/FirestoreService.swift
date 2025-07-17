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
        try usersCollection.document(user.id).setData(from: user, merge: true)
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
    
    //MARK: MoodEntries
    
    func saveMoodEntry(uid: String, moodValue: Double) async throws {
           let moodEntry = MoodEntry(
               value: moodValue,
               timestamp: Timestamp(date: Date())
           )
           // This correctly saves the entry to a subcollection within the user's document
           try await userDocument(uid: uid).collection("moodEntries").addDocument(from: moodEntry)
       }
    
    func saveEnergyEntry(uid: String, energyValue: Double) async throws {
           let energyEntry = EnergyEntry(
               value: energyValue,
               timestamp: Timestamp(date: Date())
           )
           // This correctly saves the entry to a subcollection within the user's document
           try await userDocument(uid: uid).collection("energyEntries").addDocument(from: energyEntry)
       }
}
