//
//  NotificationsView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/8/25.
//

import SwiftUI

struct NotificationsView: View {

    // 1. Initialize the ViewModel with the hasCompletedOnboarding binding
    // We use a custom init for the View to pass this binding down.
    @StateObject private var viewModel: NotificationsViewModel

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var sessionManager: SessionManager

    // This view is the final stop for passing this binding.
    @Binding var hasCompletedOnboarding: Bool
    @State private var navigateToTransition = false

    init(hasCompletedOnboarding: Binding<Bool>) {
        self._hasCompletedOnboarding = hasCompletedOnboarding // Initialize the binding
        // Initialize the StateObject with the binding
        self._viewModel = StateObject(wrappedValue: NotificationsViewModel(hasCompletedOnboarding: hasCompletedOnboarding))
    }

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
            // No need to request permission on every change if the user declines initially.
            // It's better to request it once when they explicitly enable the first one, or "Enable all."
            // However, your current logic of requesting on each toggle change is fine for initial setup.
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
                    // Pass the binding directly to the ViewModel's function
                    await viewModel.finishOnboarding(sessionManager: sessionManager, hasCompletedOnboarding: $hasCompletedOnboarding)
                    navigateToTransition = true
                }
            }
            .buttonStyle(.primary)
        }
        .padding()
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar { CustomBackButtonToolbar() }
        .navigationDestination(isPresented: $navigateToTransition) {
                    WelcomeTransitionView(hasCompletedOnboarding: $hasCompletedOnboarding)
                        // Hide the back button so the user can't go back during the transition
                        .navigationBarBackButtonHidden(true)
                }
    }
}

// MARK: - Previews
struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        // For preview, we need to create a @State variable to act as the binding source
        @State var previewHasCompletedOnboarding = false

        NavigationStack {
            // Instantiate NotificationsView, passing the preview binding
            NotificationsView(hasCompletedOnboarding: $previewHasCompletedOnboarding)
                .environmentObject(SessionManager()) // Provide a SessionManager for the preview
        }
    }
}
