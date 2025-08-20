//
//  PregnantQuestionViewModel.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 8/12/25.
//


import Foundation

@MainActor
class PregnantQuestionViewModel: ObservableObject {
    @Published var navigateToFirstPregnancy = false
    @Published var errorMessage: String?

    func handleSelection() {
        // Simple validation, navigation is handled by the view
        navigateToFirstPregnancy = true
    }
}