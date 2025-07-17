//
//  NotificationsViewModel.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/8/25.
//


import Foundation
import FirebaseAuth

@MainActor
class NotificationsViewModel: ObservableObject {
    
    @Published var allowMoodCheckins = false
    @Published var allowEpdsAssessments = false
    @Published var allowDailyAffirmations = false
    
    private let notificationsService = UserNotificationsService()
    private let firestoreService = FirestoreService()
    
    // This function requests permission from the system if any toggle is turned on.
    func requestNotificationsPermission() {
        Task {
            do {
                try await notificationsService.requestAuthorization()
            } catch {
                print("Error requesting notification permission: \(error.localizedDescription)")
            }
        }
    }
    
    func enableAll() {
        allowMoodCheckins = true
        allowEpdsAssessments = true
        allowDailyAffirmations = true
        requestNotificationsPermission()
    }
    
    func finishOnboarding(sessionManager: SessionManager) async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let preferences = NotificationPreferences(
            moodCheckins: allowMoodCheckins,
            epdsAssessments: allowEpdsAssessments,
            dailyAffirmations: allowDailyAffirmations
        )
        
        do {
            try await firestoreService.updateUserPreferences(uid: uid, preferences: preferences)
            print("Successfully saved notification preferences.")
            sessionManager.isOnboardingComplete = true
            
        } catch {
            print("Error saving preferences: \(error.localizedDescription)")
        }
    }
}
