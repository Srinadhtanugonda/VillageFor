import SwiftUI

struct FirstPostpartumExperienceView: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    // Receive the shared data model
    @ObservedObject var onboardingData: OnboardingData
    @Binding var hasCompletedOnboarding: Bool
    
    // This view's specific ViewModel
    @StateObject private var viewModel = FirstPostpartumExperienceViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Is this your first postpartum experience?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            VStack(spacing: 12) {
                ForEach(YesNoOption.allCases, id: \.self) { option in
                    Button(action: {
                        withAnimation { onboardingData.isFirstPostpartumExperience = option }
                    }) {
                        HStack {
                            Text(option.rawValue)
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            if onboardingData.isFirstPostpartumExperience == option {
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
                                    onboardingData.isFirstPostpartumExperience == option ? Color("ThemeGreen") : Color.clear,
                                    lineWidth: 1.5
                                )
                        )
                        .scaleEffect(onboardingData.isFirstPostpartumExperience == option ? 1.0 : 1.0)
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
            .disabled(onboardingData.isFirstPostpartumExperience == nil)
        }
        .padding()
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // Your custom back button component would go here
             CustomBackButtonToolbar()
        }
        .navigationDestination(
            isPresented: $viewModel.navigateToMentalHealthPro,
            destination: {
                MentalHealthProfessionalView(
                    onboardingData: onboardingData,
                    hasCompletedOnboarding: $hasCompletedOnboarding
                )
                .environmentObject(sessionManager)
            }
        )
    }
}

// MARK: - Previews
struct FirstPostpartumExperienceView_Previews: PreviewProvider {
    static var previews: some View {
        @State var previewHasCompletedOnboarding = false
        
        NavigationStack {
            FirstPostpartumExperienceView(
                onboardingData: OnboardingData(),
                hasCompletedOnboarding: $previewHasCompletedOnboarding
            )
            .environmentObject(SessionManager())
        }
    }
}
