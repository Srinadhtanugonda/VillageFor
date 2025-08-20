//
//  DataConsentView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//


import SwiftUI

struct DataConsentView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel: DataConsentViewModel
    @EnvironmentObject var sessionManager: SessionManager
    
    
    @Binding var hasCompletedOnboarding: Bool 

    init(hasCompletedOnboarding: Binding<Bool>) {
        self._hasCompletedOnboarding = hasCompletedOnboarding
        self._viewModel = StateObject(wrappedValue: DataConsentViewModel(hasCompletedOnboarding: hasCompletedOnboarding)) // Pass to ViewModel
    }

    
    //URLs for your legal documents
    private let privacyPolicyURL = URL(string: "https://www.google.com/policies/privacy/")!
    private let termsOfUseURL = URL(string: "https://www.google.com/policies/terms/")!
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            VStack(alignment: .leading, spacing: 8) {
                Text("About your data")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("We will never share your data with any company but VillageFor. You can delete your data at any time.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            CheckboxView(
                isChecked: $viewModel.agreesToHealthData,
                label: "I agree to processing of my personal health data for providing me Villagefor app functions"
            )
            
            CheckboxView(isChecked: $viewModel.agreesToTerms) {
                AnyView(
                    // Using markdown to easily create inline links
                    Text("I agree to the [Privacy Policy](\(privacyPolicyURL)) and [Terms of Use](\(termsOfUseURL))")
                        .font(.body)
                        .tint(Color("ThemeGreen"))

                        // This environment setting makes the links green
                        .environment(\.openURL, OpenURLAction { url in
                            // Handle the link tap here if needed,
                            // otherwise return .systemAction to open in browser
                            .systemAction
                        })
                )
            }

            Spacer()
            
            // Continue Button
            Button(action: {
                viewModel.completeDataConsent()
            }) {
                Text("Continue")
                }
            .buttonStyle(.primary)
            .disabled(viewModel.isContinueButtonDisabled)
        }
        .padding()
        .navigationBarBackButtonHidden(true) // Ensures the back button is visible
        .navigationTitle("") // Hides the title from the navigation bar itself
        //.navigationBarTitleDisplayMode(.inline)
        .toolbar {
            CustomBackButtonToolbar()
                }
        .navigationDestination(
                    isPresented: $viewModel.consentComplete,
                    destination: {   EmergencyDisclaimerView(hasCompletedOnboarding: $hasCompletedOnboarding) // Pass the binding!
                        .environmentObject(sessionManager) }
                )
    }
}

#Preview {
    NavigationStack {
        @State var previewHasCompletedOnboarding = false
        DataConsentView(hasCompletedOnboarding: $previewHasCompletedOnboarding).environmentObject(SessionManager())
    }
}
