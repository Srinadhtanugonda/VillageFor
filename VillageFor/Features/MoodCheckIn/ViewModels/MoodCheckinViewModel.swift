//
//  MoodCheckinViewModel.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/8/25.
//


import Foundation

@MainActor
class MoodCheckinViewModel: ObservableObject {
    
    // The slider value, from 0.0 (bottom) to 1.0 (top)
    @Published var moodValue: Double = 0.5
    var dailyCheckin: DailyCheckin
    @Published var shouldNavigateToEnergyCheck = false
    
    init(dailyCheckin: DailyCheckin) {
        self.dailyCheckin = dailyCheckin
    }
    
    func continueTapped() {
        shouldNavigateToEnergyCheck = true
        print("Navigate to Energy check")
    }
    
}
