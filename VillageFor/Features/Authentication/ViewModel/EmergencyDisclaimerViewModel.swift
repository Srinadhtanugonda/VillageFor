//
//  EmergencyDisclaimerViewModel.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//


import Foundation

@MainActor
class EmergencyDisclaimerViewModel: ObservableObject {
    
    @Published var shouldNavigateToNextStep = false
    
    func yesButtonTapped() {
        // IMPORTANT: In a real app, this should immediately direct the user
        // to emergency resources. For example, by showing a special view
        // with phone numbers like 911, the National Suicide Prevention Lifeline (988),
        // or by attempting to dial the number.
        print("YES tapped: Show emergency resources now.")
        // For now, we'll just print, but this is a critical safety feature.
    }
    
    func noButtonTapped() {
        // If the user selects "No", they can continue into the main app.
        // Here you would likely dismiss the entire authentication flow.
        print("NO tapped in EmergencyDisclaimerViewModel, navigatig to create profile screen")
        shouldNavigateToNextStep = true
    }
}
