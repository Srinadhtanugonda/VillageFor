//
//  PostpartumViewModel.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 8/12/25.
//


import Foundation

@MainActor
class PostpartumViewModel: ObservableObject {
    @Published var navigateToPostpartumWeeks = false
    @Published var navigateToMentalHealthPro = false
    @Published var errorMessage: String?

    func handleSelection(for selection: YesNoOption) {
        if selection == .yes {
            navigateToPostpartumWeeks = true
        } else {
            // If user is not postpartum, skip to the mental health question
            navigateToMentalHealthPro = true
        }
    }
}