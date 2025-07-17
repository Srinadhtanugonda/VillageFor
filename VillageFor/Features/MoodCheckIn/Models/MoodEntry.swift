//
//  MoodEntry.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/8/25.
//


import Foundation
import FirebaseFirestore

struct MoodEntry: Identifiable, Codable {
    @DocumentID var id: String?
    let value: Double
    let timestamp: Timestamp
}

struct EnergyEntry: Identifiable, Codable {
    @DocumentID var id: String?
    let value: Double 
    let timestamp: Timestamp
}
