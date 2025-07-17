//
//  HomeViewModel.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/2/25.
//


import Foundation
import SwiftUICore

@MainActor
class HomeViewModel: ObservableObject {
    
    
    @Published var userName: String
    @Published var dailyAffirmation: Affirmation
    @Published var supportArticles: [Article]
    
    private let authService = AuthenticationService()
    
    @Published var shouldNavigateToMoodCheck = false
    @Published var shouldNavigateToEPDSAssessment = false
    
    
    
    
    init(user: User) {
        self.userName = user.firstName ?? "User"
        
        // Initializing with sample data
        self.dailyAffirmation = Affirmation(
            text: "I release guilt about not being with my child every moment. I provide for and nurture my child in my own unique way."
        )
        //Later we can call live articles using API here.
        self.supportArticles = [
            Article(
                title: "What to expect during morning sickness",
                description: "Learn about common symptoms and coping strategies during early pregnancy.",
                imageURL: "https://example.com/morning-sickness.jpg"
            ),
            Article(
                title: "Preparing for your baby's arrival",
                description: "Essential tips for getting ready for your new bundle of joy.",
                imageURL: "https://example.com/baby-prep.jpg"
            )
        ]
    }
    
    
    func signOut() {
        do {
            try authService.signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    func navigateToMoodCheck() {
        shouldNavigateToMoodCheck = true
        print("Navigate to mood check")
    }
    
    func navigateToEPDSAssessment() {
        shouldNavigateToEPDSAssessment = true
        print("Navigate to EPDS assessment")
    }
}
