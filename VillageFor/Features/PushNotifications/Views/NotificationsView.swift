//
//  NotificationsView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/8/25.
//


import SwiftUI

struct NotificationsView: View {
    
    @StateObject private var viewModel = NotificationsViewModel()
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Turn on notifications to see all your village can offer")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            VStack(spacing: 24) {
                Toggle(isOn: $viewModel.allowMoodCheckins) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Mood check-ins").fontWeight(.semibold)
                        Text("Check in daily for the most accurate insights and affirmations").font(.subheadline).foregroundColor(.secondary)
                    }
                }
                
                Toggle(isOn: $viewModel.allowEpdsAssessments) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("EPDS weekly assessment").fontWeight(.semibold)
                        Text("The Edinburgh Postnatal Depression Scale (EPDS) monitors how you're doing on the same scale that doctors use").font(.subheadline).foregroundColor(.secondary)
                    }
                }
                
                Toggle(isOn: $viewModel.allowDailyAffirmations) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Daily affirmations").fontWeight(.semibold)
                        Text("Encouragement delivered right to your phone").font(.subheadline).foregroundColor(.secondary)
                    }
                }
            }
            .toggleStyle(SwitchToggleStyle(tint: Color("ThemeGreen")))
            .onChange(of: viewModel.allowMoodCheckins) { if $1 { viewModel.requestNotificationsPermission() }}
            .onChange(of: viewModel.allowEpdsAssessments) { if $1 { viewModel.requestNotificationsPermission() }}
            .onChange(of: viewModel.allowDailyAffirmations) { if $1 { viewModel.requestNotificationsPermission() }}
            
            Spacer()
            
            Button("Enable all") {
                viewModel.enableAll()
            }
            .frame(maxWidth: .infinity)
            
            Button("Finish") {
                Task {
                    await viewModel.finishOnboarding(sessionManager: sessionManager)
                }
            }
            .buttonStyle(.primary)
        }
        .padding()
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar { CustomBackButtonToolbar() }
    }
}


#Preview {
    NavigationStack {
        NotificationsView().environmentObject(SessionManager())
    }
}
