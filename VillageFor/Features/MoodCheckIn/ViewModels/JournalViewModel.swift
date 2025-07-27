//
//  JournalViewModel.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/21/25.
//

import Foundation
import FirebaseAuth

@MainActor
class JournalViewModel: ObservableObject {
    
    // This property holds the check-in data from the previous screens.
    private var dailyCheckin: DailyCheckin
    
    // A computed property to easily access the emotion.
    var emotion: String {
        dailyCheckin.selectedEmotion ?? "feeling"
    }
    
    // Data for the view
    let prompts: [String]
    let allFactors = ["Better sleep", "Journaled", "Meditated", "Baby blues", "Therapy", "Medication"]
    
    // State for user input
    @Published var journalText = ""
    @Published var selectedFactors = Set<String>()
    
    // This flag will signal the view to dismiss the flow when saving is complete.
    @Published var didSaveEntry = false
    
    private let firestoreService: FirestoreServiceProtocol
    
    // The initializer now takes the DailyCheckin object and the service.
    init(dailyCheckin: DailyCheckin, firestoreService: FirestoreServiceProtocol = FirestoreService()) {
        self.dailyCheckin = dailyCheckin
        self.firestoreService = firestoreService
        
        // Customize prompts based on the selected emotion
        let emotionWord = (dailyCheckin.selectedEmotion ?? "feeling").lowercased()
        self.prompts = ["I'm \(emotionWord) that...", "In this moment...", "I felt \(emotionWord) when..."]
    }
    
    // Appends a prompt to the journal text
    func selectPrompt(_ prompt: String) {
        // Add a space if the text field isn't empty
        if !journalText.isEmpty {
            journalText += " "
        }
        journalText += prompt
    }
    
    // Adds or removes a factor from the selected set
    func toggleFactor(_ factor: String) {
        if selectedFactors.contains(factor) {
            selectedFactors.remove(factor)
        } else {
            selectedFactors.insert(factor)
        }
    }
    
    /// This is the final save function for the entire check-in flow.
    func saveEntry() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // 1. Update the dailyCheckin object with the final details.
        dailyCheckin.journalText = self.journalText
        dailyCheckin.factors = Array(self.selectedFactors)
        
        do {
            // 2. Save the completed object to Firestore.
            try await firestoreService.saveDailyCheckin(uid: uid, checkin: dailyCheckin)
            print("✅ Journal entry saved successfully!")
            
            // 3. Set the flag to true to signal the UI to dismiss.
            didSaveEntry = true
            
        } catch {
            print("❌ Error saving journal entry: \(error.localizedDescription)")
        }
    }
}
