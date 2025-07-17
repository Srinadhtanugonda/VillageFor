////
////  MockFirestoreService_Tests.swift
////  VillageForTests
////
////  Created by Srinadh Tanugonda on 7/8/25.
////
//
//import XCTest
//@testable import VillageFor
//
//// MARK: - Mock Firestore Service
//
//// This is a "fake" version of our FirestoreService for testing.
//@MainActor
//class MockFirestoreService: FirestoreServiceProtocol {
//    // Properties to track which functions were called
//
//    var saveUserProfileCalled = false
//    var updateUserAgeCalled = false
//    var saveUserConsentCalled = false
//
//    // A property to simulate errors
//
//    var shouldThrowError = false
//
//    enum MockFirestoreError: Error {
//        case failedToSave
//    }
//
//    // We don't need to implement the real logic, just track the calls.
//
//    func saveUserProfile(user: User) async throws {
//        if shouldThrowError { throw MockFirestoreError.failedToSave }
//        saveUserProfileCalled = true
//    }
//
//    func updateUserAge(uid: String, age: Int) async throws {
//        if shouldThrowError { throw MockFirestoreError.failedToSave }
//        updateUserAgeCalled = true
//    }
//
//    func saveUserConsent(agreedToHealthData: Bool, agreedToTerms: Bool) async throws {
//        if shouldThrowError { throw MockFirestoreError.failedToSave }
//        saveUserConsentCalled = true
//    }
//
//}
