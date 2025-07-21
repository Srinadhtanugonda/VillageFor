//
//  MockFirestoreService_Tests.swift
//  VillageForTests
//
//  Created by Srinadh Tanugonda on 7/8/25.
//

import XCTest
@testable import VillageFor

// MARK: - Mock Firestore Service

// This is a "fake" version of our FirestoreService for testing.
@MainActor
class MockFirestoreService: FirestoreServiceProtocol {
    // Properties to track which functions were called
    
    var saveUserProfileCalled = false
    var updateUserAgeCalled = false
    var saveUserConsentCalled = false
    var updateUserPreferencesCalled = false
    var fetchUserProfileCalled = false
    var saveMoodEntryCalled = false
    var saveEnergyEntryCalled = false
    
    // A property to simulate errors
    
    var shouldThrowError = false
    
    enum MockFirestoreError: Error {
        //Adding cases here, so that we can find specific errors here if occurred.
        case failedToSaveProfile
        case failedToSaveAge
        case failedToSaveDataConsent
        case failedToUpdateUserPreferences
        case failedToFetchUserProfile
        case failedToSaveMoodEntry
        case failedToSaveEnergyEntry
    }
    
    // We don't need to implement the real logic, just track the calls.
    
    func saveUserProfile(user: User) async throws {
        if shouldThrowError { throw MockFirestoreError.failedToSaveProfile }
        saveUserProfileCalled = true
    }
    
    func updateUserAge(uid: String, age: Int) async throws {
        if shouldThrowError { throw MockFirestoreError.failedToSaveAge }
        updateUserAgeCalled = true
    }
    
    func saveUserConsent(agreedToHealthData: Bool, agreedToTerms: Bool) async throws {
        if shouldThrowError { throw MockFirestoreError.failedToSaveDataConsent }
        saveUserConsentCalled = true
    }
    
    func updateUserPreferences(uid: String, preferences: NotificationPreferences) async throws {
            if shouldThrowError { throw MockFirestoreError.failedToUpdateUserPreferences }
            updateUserPreferencesCalled = true
        }
        
        func fetchUserProfile(uid: String) async throws -> User? {
            if shouldThrowError { throw MockFirestoreError.failedToFetchUserProfile }
            fetchUserProfileCalled = true
            // Return a sample user for tests that need it
            return User(id: uid, email: "mock@test.com", firstName: "Mock")
        }
        
        func saveMoodEntry(uid: String, moodValue: Double) async throws {
            if shouldThrowError { throw MockFirestoreError.failedToSaveMoodEntry }
            saveMoodEntryCalled = true
        }
        
        func saveEnergyEntry(uid: String, energyValue: Double) async throws {
            if shouldThrowError { throw MockFirestoreError.failedToSaveEnergyEntry }
            saveEnergyEntryCalled = true
        }
    
}
