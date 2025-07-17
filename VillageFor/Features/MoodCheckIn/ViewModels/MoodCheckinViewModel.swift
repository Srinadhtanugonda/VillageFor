//
//  MoodCheckinViewModel.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/8/25.
//


import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
class MoodCheckinViewModel: ObservableObject {
    
    // The slider value, from 0.0 (bottom) to 1.0 (top)
    @Published var sliderValue: Double = 0.5
    
    private let firestoreService = FirestoreService()
    
    func saveMoodEntry() async {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Error: User not logged in. Mood entry can't be saved.")
            return
        }
        
        do {
            try await firestoreService.saveMoodEntry(uid: uid, moodValue: sliderValue)
            print("Mood entry saved successfully!")
            // Here we will dismiss the view after saving.
        } catch {
            print("Error saving mood entry: \(error.localizedDescription)")
        }
    }
}
