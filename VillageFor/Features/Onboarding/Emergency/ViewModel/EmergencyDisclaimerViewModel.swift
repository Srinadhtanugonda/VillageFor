//
//  EmergencyDisclaimerViewModel.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//


import Foundation
import SwiftUI

@MainActor
class EmergencyDisclaimerViewModel: ObservableObject {
    
    @Published var shouldNavigateToNextStep = false
    @Published var shouldNavigateToEmergencyHelp = false
    @Binding var hasCompletedOnboarding: Bool
    
    init(hasCompletedOnboarding: Binding<Bool>) {
          self._hasCompletedOnboarding = hasCompletedOnboarding
      }
    
    func yesButtonTapped() {
        // User is experiencing a mental health crisis - navigate to emergency help screen
        print("YES tapped: Navigating to emergency help resources.")
        shouldNavigateToEmergencyHelp = true
    }
    
    func noButtonTapped() {
        // If the user selects "No", they can continue into the main app flow.
        print("NO tapped: User is not in crisis, continuing to create profile screen")
        shouldNavigateToNextStep = true
    }
}
