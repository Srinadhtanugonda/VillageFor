//
//  FirestoreServiceProtocol.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/8/25.
//

import Foundation

// This protocol defines the "contract" for what a Firestore service must do.
protocol FirestoreServiceProtocol {
    func saveUserProfile(user: User) async throws
    func updateUserAge(uid: String, age: Int) async throws
    func saveUserConsent(agreedToHealthData: Bool, agreedToTerms: Bool) async throws
    // We would add other functions here, like fetchUserProfile, etc.
}
