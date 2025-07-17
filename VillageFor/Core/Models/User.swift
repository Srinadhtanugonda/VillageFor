//
//  User.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//

import Foundation
import FirebaseCore
import FirebaseFirestore // Required for the Timestamp type

struct User: Identifiable, Codable {
    let id: String
    let email: String
    
    // We can add new optional fields for the profile information
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    var age: Int?
    var dataConsent: DataConsent?
    var notificationPreferences: NotificationPreferences?
    
    var fullName: String {
        "\(firstName ?? "") \(lastName ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
    }
}


struct DataConsent: Codable {
    var terms: ConsentItem?
    var healthData: ConsentItem
}

struct ConsentItem: Codable {
    /// we will keep this Non-optional for clarity (it's either true or false).
    var isAgreed: Bool
    var timestamp: Timestamp
    var version: String
}



struct NotificationPreferences: Codable {
    var moodCheckins: Bool = false
    var epdsAssessments: Bool = false
    var dailyAffirmations: Bool = false
}
