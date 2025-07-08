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
                CreateProfileView()
                    .environmentObject(sessionManager)
            }
        )
    }
}

#Preview {
    NavigationStack {
        LoginView()
            .environmentObject(SessionManager())
    }
}
