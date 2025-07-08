//
//  User.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//

import Foundation
import FirebaseCore

struct User: Identifiable, Codable {
    let id: String
    let email: String
    
    // Add new optional fields for the profile information
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    var age: Int?
    var dataConsent: DataConsent?
    
    // Add a computed property for display name
    var fullName: String {
        "\(firstName ?? "") \(lastName ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
    }
}


struct DataConsent: Codable {
    var agreedToHealthData: Bool?
    var agreedToTerms: Bool?
    var consentTimestamp: Timestamp?
}
