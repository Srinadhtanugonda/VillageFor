//
//  FirstPostpartumExperienceViewModel.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 8/12/25.
//


import Foundation

@MainActor
class FirstPostpartumExperienceViewModel: ObservableObject {
    @Published var navigateToMentalHealthPro = false
    @Published var errorMessage: String?
    
    func handleSelection() {
        navigateToMentalHealthPro = true
    }
}