import SwiftUI

struct PregnantQuestionView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @Binding var hasCompletedOnboarding: Bool

    // Create the shared data model here. It will be passed through the flow.
    @StateObject private var onboardingData = OnboardingData()
    
    // This view's specific ViewModel
    @StateObject private var viewModel = PregnantQuestionViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Are you currently pregnant?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            VStack(spacing: 12) {
                // The ForEach loop is now much simpler
                ForEach(PregnancyStatus.allCases, id: \.self) { status in
                    // Call the helper function to create the button
                    pregnancyStatusButton(for: status)
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
            .disabled(onboardingData.pregnancyStatus == nil)
        }
        .padding()
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // Your custom back button component would go here
             CustomBackButtonToolbar()
        }
        .navigationDestination(
            isPresented: $viewModel.navigateToFirstPregnancy,
            destination: {
                FirstPregnancyView(
                    onboardingData: onboardingData,
                    hasCompletedOnboarding: $hasCompletedOnboarding
                )
                .environmentObject(sessionManager)
            }
        )
    }

    // --- HELPER FUNCTION ---
    // This private function builds the complex button view, solving the compiler error.
    private func pregnancyStatusButton(for status: PregnancyStatus) -> some View {
        Button(action: {
            withAnimation { onboardingData.pregnancyStatus = status }
        }) {
            HStack {
                Text(status.rawValue)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.primary)
                
                Spacer()
                
                if onboardingData.pregnancyStatus == status {
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
                        onboardingData.pregnancyStatus == status ? Color("ThemeGreen") : Color.clear,
                        lineWidth: 1.5
                    )
            )
            .scaleEffect(onboardingData.pregnancyStatus == status ? 1.0 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
