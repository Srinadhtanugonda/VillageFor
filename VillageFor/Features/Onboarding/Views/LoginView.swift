//
//  LoginView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//

import SwiftUI

struct LoginView: View {

    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject var sessionManager: SessionManager

    @Binding var hasCompletedOnboarding: Bool

    init(hasCompletedOnboarding: Binding<Bool>) {
        self._hasCompletedOnboarding = hasCompletedOnboarding
        // ViewModel can be initialized without the binding directly
        // if it doesn't need to directly modify `hasCompletedOnboarding`.
        // However, if your LoginViewModel might directly set it, you'd pass it.
        // For now, assuming it's passed down to the next onboarding view.
        self._viewModel = StateObject(wrappedValue: LoginViewModel())
    }

    var body: some View {
        VStack(alignment: .leading) {

            Text("Welcome back")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            VStack(spacing: 25) {
                FloatingLabelTextField(text: $viewModel.email, placeholder: "Email Address").keyboardType(.emailAddress)

                FloatingLabelTextField(text: $viewModel.password, placeholder: "Password", isSecure: true)
            }

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.top)
            }

            Spacer()

            Button("Log In") {
                Task {
                    await viewModel.login(sessionManager: sessionManager)
                }
            }
            .buttonStyle(.primary)
            .disabled(viewModel.isLoginButtonDisabled)

        }
        .padding()
        .background(Color.white.ignoresSafeArea())
        .navigationTitle("Log In")
        .navigationBarTitleDisplayMode(.inline)
        // This destination will only trigger if the user needs to complete their profile
        .navigationDestination(
            isPresented: $viewModel.navigateToCreateProfile,
            destination: {
                CreateProfileView(hasCompletedOnboarding: $hasCompletedOnboarding)
                    .environmentObject(sessionManager)
            }
        )
    }
}

#Preview {
    // For preview, create a @State variable to act as the binding source
    @State var previewHasCompletedOnboarding = false

    NavigationStack {
        LoginView(hasCompletedOnboarding: $previewHasCompletedOnboarding) // Pass the binding here
            .environmentObject(SessionManager())
    }
}
