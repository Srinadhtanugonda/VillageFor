import SwiftUI

struct PostpartumView: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    // Receive the shared data model
    @ObservedObject var onboardingData: OnboardingData
    @Binding var hasCompletedOnboarding: Bool
    
    // This view's specific ViewModel
    @StateObject private var viewModel = PostpartumViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Are you postpartum?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            VStack(spacing: 12) {
                ForEach(YesNoOption.allCases, id: \.self) { option in
                    Button(action: {
                        withAnimation { onboardingData.isPostpartum = option }
                    }) {
                        HStack {
                            Text(option.rawValue)
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            if onboardingData.isPostpartum == option {
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
                                    onboardingData.isPostpartum == option ? Color("ThemeGreen") : Color.clear,
                                    lineWidth: 1.5
                                )
                        )
                        .scaleEffect(onboardingData.isPostpartum == option ? 1.0 : 1.0)
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
                // Safely unwrap the selection before passing it to the view model
                guard let selection = onboardingData.isPostpartum else { return }
                viewModel.handleSelection(for: selection)
            }
            .buttonStyle(.primary)
            .disabled(onboardingData.isPostpartum == nil)
        }
        .padding()
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar {
             CustomBackButtonToolbar()
        }
        // Navigation for 'Yes' answer
        .navigationDestination(
            isPresented: $viewModel.navigateToPostpartumWeeks,
            destination: {
                // This would be your PostpartumWeeksView
                // For now, using a placeholder:
                PostpartumWeeksView(
                    onboardingData: onboardingData,
                    hasCompletedOnboarding: $hasCompletedOnboarding
                )
                .environmentObject(sessionManager)
            }
        )
        // Navigation for 'No' answer
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
struct PostpartumView_Previews: PreviewProvider {
    static var previews: some View {
        @State var previewHasCompletedOnboarding = false
        
        NavigationStack {
            PostpartumView(
                onboardingData: OnboardingData(),
                hasCompletedOnboarding: $previewHasCompletedOnboarding
            )
            .environmentObject(SessionManager())
        }
    }
}
