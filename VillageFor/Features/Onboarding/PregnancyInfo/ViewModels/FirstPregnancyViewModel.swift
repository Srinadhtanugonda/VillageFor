//
//  FirstPregnancyViewModel.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 8/12/25.
//


import Foundation

@MainActor
class FirstPregnancyViewModel: ObservableObject {
    @Published var navigateToPostpartum = false
    @Published var errorMessage: String?

    func handleSelection() {
        navigateToPostpartum = true
    }
}