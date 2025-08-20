//
//  MentalHealthProfessionalView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/31/25.
//
import SwiftUI

struct MentalHealthProfessionalView: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    // Receive the shared data model, which is now complete
    @ObservedObject var onboardingData: OnboardingData
    @Binding var hasCompletedOnboarding: Bool
    
    // The ViewModel with the final save logic
    @StateObject private var viewModel = MentalHealthProfessionalViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Are you currently working with a mental health professional?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            VStack(spacing: 12) {
                ForEach(WorkingWithMentalHealthProfessional.allCases, id: \.self) { option in
                    Button(action: {
                        withAnimation { onboardingData.workingWithMentalHealthPro = option }
                    }) {
                        HStack {
                            Text(option.rawValue)
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            if onboardingData.workingWithMentalHealthPro == option {
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
                                    onboardingData.workingWithMentalHealthPro == option ? Color("ThemeGreen") : Color.clear,
                                    lineWidth: 1.5
                                )
                        )
                        .scaleEffect(onboardingData.workingWithMentalHealthPro == option ? 1.0 : 1.0)
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

            Button(action: {
                // Run the async save function in a Task
                Task {
                    await viewModel.saveAllOnboardingData(
                        data: onboardingData,
                        sessionManager: sessionManager
                    )
                }
            }) {
                // Show a loading indicator while saving
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("Continue")
                }
            }
            .buttonStyle(.primary)
            .disabled(onboardingData.workingWithMentalHealthPro == nil || viewModel.isLoading)
        }
        .padding()
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar {
             CustomBackButtonToolbar()
        }
        .navigationDestination(
            isPresented: $viewModel.navigateToNotifications,
            destination: {
//                // This will navigate to the next major screen in your app
//                // For now, using a placeholder:
//                 Text("Next Screen: Notifications View")
                
                NotificationsView(hasCompletedOnboarding: $hasCompletedOnboarding)
                    .environmentObject(sessionManager)
                
            }
        )
    }
}

// MARK: - Previews
struct MentalHealthProfessionalView_Previews: PreviewProvider {
    static var previews: some View {
        @State var previewHasCompletedOnboarding = false
        
        NavigationStack {
            MentalHealthProfessionalView(
                onboardingData: OnboardingData(),
                hasCompletedOnboarding: $previewHasCompletedOnboarding
            )
            .environmentObject(SessionManager())
        }
    }
}
