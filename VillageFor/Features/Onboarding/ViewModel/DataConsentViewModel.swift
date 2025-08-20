//
//  DataConsentViewModel.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//


import Foundation
import SwiftUI

@MainActor
class DataConsentViewModel: ObservableObject {
    
    @Published var agreesToHealthData = false
    @Published var agreesToTerms = false
    @Published var consentComplete = false
    @Binding var hasCompletedOnboarding: Bool
    
    init(hasCompletedOnboarding: Binding<Bool>) {
           self._hasCompletedOnboarding = hasCompletedOnboarding
       }

    
//       private let firestoreService: FirestoreServiceProtocol
//       
//       init(firestoreService: FirestoreServiceProtocol = FirestoreService()) {
//           self.firestoreService = firestoreService
//       }
//    
    //MARK: here we should implement userDefaults to save the userConsent data and then save to cloud when proceeding the last step.
    // A computed property to determine if the continue button should be enabled.
    var isContinueButtonDisabled: Bool {
        // It's disabled if either of the boxes is not checked.
        !agreesToHealthData || !agreesToTerms
    }
    
    func completeDataConsent() {
        // Here, you would perform the final step, like marking the user's
        // profile as "onboarding_complete" in your database (e.g., Firestore).
        // After this, you would programmatically dismiss the auth flow.
        self.consentComplete = true
        print("Data consent is given, navigating to  emergency disclaimer screen")
        agreesToHealthData = true
        agreesToTerms = true
       
    }
}
