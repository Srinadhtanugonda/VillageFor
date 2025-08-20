//
//  User.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//

import Foundation
import FirebaseCore
import FirebaseFirestore // Required for the Timestamp type

struct User: Identifiable, Codable, Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: String
    let email: String
    
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    var age: Int?
    var dataConsent: DataConsent?
    var notificationPreferences: NotificationPreferences?
    var pregnancyStatus: String?
    var isFirstPregnancy: Bool?
    var isPostpartum: Bool?
    var postpartumWeeks: Int?
    var isFirstPostpartumExperience: Bool?
    var mentalHealthProfessionalType: String?
    
    var fullName: String {
        "\(firstName ?? "") \(lastName ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
}


struct DataConsent: Codable, Equatable {
    var terms: ConsentItem?
    var healthData: ConsentItem
    static func == (lhs: DataConsent, rhs: DataConsent) -> Bool {
           lhs.terms == rhs.terms && lhs.healthData == rhs.healthData
       }
}

struct ConsentItem: Codable, Equatable {
    /// we will keep this Non-optional for clarity (it's either true or false).
    var isAgreed: Bool
    var timestamp: Timestamp
    var version: String
    static func == (lhs: ConsentItem, rhs: ConsentItem) -> Bool {
            lhs.isAgreed == rhs.isAgreed && lhs.timestamp == rhs.timestamp && lhs.version == rhs.version
        }
}



struct NotificationPreferences: Codable, Equatable {
    var moodCheckins: Bool = false
    var epdsAssessments: Bool = false
    var dailyAffirmations: Bool = false
    static func == (lhs: NotificationPreferences, rhs: NotificationPreferences) -> Bool {
            lhs.moodCheckins == rhs.moodCheckins && lhs.epdsAssessments == rhs.epdsAssessments && lhs.dailyAffirmations == rhs.dailyAffirmations
        }
}
