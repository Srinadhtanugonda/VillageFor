//
//  UserNotificationsService.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/8/25.
//


import Foundation
import UserNotifications

class UserNotificationsService {
    
    /// Requests authorization from the user to send push notifications.
    func requestAuthorization() async throws {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        try await UNUserNotificationCenter.current().requestAuthorization(options: options)
    }
}