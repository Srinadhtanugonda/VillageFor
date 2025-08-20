//
//  UserNotificationsService.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/8/25.
//


import Foundation
import UserNotifications

class UserNotificationsService {
    func requestAuthorization() async throws {
        let center = UNUserNotificationCenter.current()
        let granted = try await center.requestAuthorization(options: [.alert, .sound, .badge])
        if granted {
            print("Notification authorization granted.")
        } else {
            print("Notification authorization denied.")
            // Handle denial, e.g., prompt user to go to settings
        }
    }
}
