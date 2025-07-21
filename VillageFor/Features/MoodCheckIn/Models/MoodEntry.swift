//
//  MoodEntry.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/8/25.
//


import Foundation
import FirebaseFirestore

struct DailyCheckin: Identifiable, Codable {
    @DocumentID var id: String?
    var moodValue: Double?
    var energyValue: Double?
    var selectedEmotion: String?
    var journalText: String?
    var factors: [String]?
    let timestamp: Timestamp
}
