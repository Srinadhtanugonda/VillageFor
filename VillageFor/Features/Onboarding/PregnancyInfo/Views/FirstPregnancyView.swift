//
//  FirstPregnancyView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/31/25.
//
import SwiftUI

struct FirstPregnancyView: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    // Receive the shared data model from the previous screen
    @ObservedObject var onboardingData: OnboardingData
    @Binding var hasCompletedOnboarding: Bool
    
    // The specific ViewModel for this view's logic
    @StateObject private var viewModel = FirstPregnancyViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Is this your first pregnancy?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            VStack(spacing: 12) {
                ForEach(YesNoOption.allCases, id: \.self) { option in
                    Button(action: {
                        withAnimation { onboardingData.isFirstPregnancy = option }
                    }) {
                        HStack {
                            Text(option.rawValue)
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            if onboardingData.isFirstPregnancy == option {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 20))
                                    .foregroundStyle(Color("ThemeGreen"))
                                    .transition(.scale.combined(with: .opacity))
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 18)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(
                                    onboardingData.isFirstPregnancy == option ? Color("ThemeGreen") : Color.clear,
                                    lineWidth: 1.5
                                )
                        )
                        .scaleEffect(onboardingData.isFirstPregnancy == option ? 1.0 : 1.0)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.top, 10)
            }
            
            Spacer()

            Button("Continue") {
                viewModel.handleSelection()
            }
            .buttonStyle(.primary)
            .disabled(onboardingData.isFirstPregnancy == nil)
        }
        .padding()
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // Your custom back button component would go here
             CustomBackButtonToolbar()
        }
        .navigationDestination(
            isPresented: $viewModel.navigateToPostpartum,
            destination: {
                PostpartumView(
                    onboardingData: onboardingData, // Pass the data model to the next screen
                    hasCompletedOnboarding: $hasCompletedOnboarding
                )
                .environmentObject(sessionManager)
            }
        )
    }
}

// MARK: - Previews
struct FirstPregnancyView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a state variable for the binding
        @State var previewHasCompletedOnboarding = false
        
        // Use a NavigationStack to see the navigation title and flow
        NavigationStack {
            FirstPregnancyView(
                onboardingData: OnboardingData(), // Provide a fresh data model for the preview
                hasCompletedOnboarding: $previewHasCompletedOnboarding
            )
            .environmentObject(SessionManager()) // Provide a dummy session manager
        }
    }
}
