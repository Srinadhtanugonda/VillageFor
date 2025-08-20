// EmergencyDisclaimerView.swift
import SwiftUI

struct EmergencyDisclaimerView: View {

    @StateObject private var viewModel: EmergencyDisclaimerViewModel // Initialize with binding
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var sessionManager: SessionManager

    // ✨ Accept the binding here ✨
    @Binding var hasCompletedOnboarding: Bool

    private let backgroundColor = Color("ThemeGreen")

    // ✨ Custom initializer to pass the binding to the ViewModel ✨
    init(hasCompletedOnboarding: Binding<Bool>) {
        self._hasCompletedOnboarding = hasCompletedOnboarding
        self._viewModel = StateObject(wrappedValue: EmergencyDisclaimerViewModel(hasCompletedOnboarding: hasCompletedOnboarding)) // Pass binding to ViewModel
    }

    var body: some View {

        ZStack {
            backgroundColor.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {

                // Title and subtitle section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Is this an emergency?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text("We want to help, but we're not an emergency service. Select yes if:")
                        .font(.body)
                        .foregroundColor(.white)
                }
                .padding(.top, 20)
                .padding(.bottom, 32)

                // Options section
                VStack(alignment: .leading, spacing: 20) {
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "arrow.right")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                            .padding(.top, 2)

                        Text("You are currently experiencing a mental health crisis")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }

                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "arrow.right")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                            .padding(.top, 2)

                        Text("You are in need of immediate help")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                }

                Spacer()

                // Image section
                Image("you_are_not_alone")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 60)
                    .opacity(0.4)
                    .padding(.bottom, 40)

                // Buttons section
                VStack(spacing: 16) {
                    Button("Yes") {
                        viewModel.yesButtonTapped()
                    }
                    .buttonStyle(.secondary)

                    Button("No") {
                        viewModel.noButtonTapped()
                    }
                    .buttonStyle(.secondary)
                }
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 24)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            CustomBackButtonToolbar(foregroundColor: Color.white)
        }
        .navigationDestination(
            isPresented: $viewModel.shouldNavigateToNextStep,
            destination: {
                // ✨ Pass the binding to CreateProfileView ✨
                CreateProfileView(hasCompletedOnboarding: $hasCompletedOnboarding)
                    .environmentObject(sessionManager)
            }
        )
        .navigationDestination(
            isPresented: $viewModel.shouldNavigateToEmergencyHelp,
            destination: {
                // For this path, onboarding is interrupted, so no need to pass the binding down further
                EmergencyHelpView()
                    .environmentObject(sessionManager)
            }
        )
    }
}

#Preview {
    @State var previewHasCompletedOnboarding = false // For preview only
    return NavigationStack {
        EmergencyDisclaimerView(hasCompletedOnboarding: $previewHasCompletedOnboarding).environmentObject(SessionManager())
    }
}
