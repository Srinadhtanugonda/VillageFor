//
//  PostpartumWeeksViewModel.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 8/12/25.
//


import Foundation

@MainActor
class PostpartumWeeksViewModel: ObservableObject {
    @Published var navigateToFirstPostpartumExperience = false
    @Published var errorMessage: String?

    func handleSelection() {
        navigateToFirstPostpartumExperience = true
    }
}