//
//  CreateProfileView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//

import SwiftUI

struct CreateProfileView: View {

    @StateObject private var viewModel: CreateProfileViewModel //Learnings: Will be initializing with binding, so for now just create variable with type CreateProfileViewModel.
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var sessionManager: SessionManager

    @Binding var hasCompletedOnboarding: Bool

    //Here we use initializer to pass the binding to the ViewModel
    init(hasCompletedOnboarding: Binding<Bool>) {
        self._hasCompletedOnboarding = hasCompletedOnboarding
        self._viewModel = StateObject(wrappedValue: CreateProfileViewModel(hasCompletedOnboarding: hasCompletedOnboarding)) // Pass binding to ViewModel, do the same way till the last screen of onboarding and turn thr flag true once the onboarding is done.
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Welcome to \nVillageFor")
                        .font(.largeTitle)
                        .fontWeight(.regular)
                        .padding(.bottom, 24)

                    VStack(spacing: 25) {
                        FloatingLabelTextField(
                            text: $viewModel.firstName,
                            placeholder: "First name",
                            errorMessage: viewModel.firstNameError,
                            onValidationNeeded: {
                                viewModel.validateFirstName()
                            }
                        )

                        FloatingLabelTextField(
                            text: $viewModel.lastName,
                            placeholder: "Last name",
                            errorMessage: viewModel.lastNameError,
                            onValidationNeeded: {
                                viewModel.validateLastName()
                            }
                        )

                        FloatingLabelTextField(
                            text: $viewModel.email,
                            placeholder: "Email address",
                            errorMessage: viewModel.emailError,
                            onValidationNeeded: {
                                viewModel.validateEmail()
                            }
                        )

                        FloatingLabelTextField(
                            text: $viewModel.password,
                            placeholder: "Password",
                            isSecure: true,
                            errorMessage: viewModel.passwordError,
                            onValidationNeeded: {
                                viewModel.validatePassword()
                            }
                        )

                        FloatingLabelTextField(
                            text: $viewModel.phoneNumber,
                            placeholder: "Phone number (optional)",
                            errorMessage: viewModel.phoneNumberError,
                            onValidationNeeded: {
                                viewModel.validatePhoneNumber()
                            }
                        )
                    }

                    // Display general error message if present
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(.top, 16)
                            .padding(.horizontal, 4)
                    }

                    Spacer()
                }
                .padding()
            }

            Button("Continue") {
                Task {
                    // Pass the existing sessionManager to the ViewModel for updating currentUser
                    await viewModel.createUserAndSaveProfile(sessionManager: sessionManager)
                }
            }
            .buttonStyle(.primary)
            .disabled(viewModel.isContinueButtonDisabled)
            .padding()
            .background(Color("LightGrayBG"))
        }
        .background(Color("LightGrayBG").ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar { CustomBackButtonToolbar() }

        // This should navigate to TransitionView when profileSaveSuccess is true
        .navigationDestination(
            isPresented: $viewModel.profileSaveSuccess,
            destination: {
                TransitionView(destination: AgePickerView(hasCompletedOnboarding: $hasCompletedOnboarding), hasCompletedOnboarding: $hasCompletedOnboarding) {
                    Text("Answer a few\nquestions to help us\nget to know you...")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                .environmentObject(sessionManager) // Pass the existing sessionManager
            }
        )
    }
}

#Preview {
    @State var previewHasCompletedOnboarding = false // For preview purposes
    return NavigationStack {
        CreateProfileView(hasCompletedOnboarding: $previewHasCompletedOnboarding) // Initialize for preview
            .environmentObject(SessionManager())
    }
}
