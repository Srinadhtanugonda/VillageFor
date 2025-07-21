//
//  SelectEmotionsViewModel.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/19/25.
//


import Foundation

@MainActor
class SelectEmotionViewModel: ObservableObject {
    
    // This will hold the check-in data passed from the previous screen.
    var dailyCheckin: DailyCheckin
    
    // The list of emotions to display
    let emotions = ["Startled", "Amazed", "Excited", "Astonished", "Awed", "Eager", "Energetic"]
    
    init(dailyCheckin: DailyCheckin) {
        self.dailyCheckin = dailyCheckin
    }
}
