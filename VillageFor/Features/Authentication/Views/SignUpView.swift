//
//  SignUpView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        
        ZStack {
            // This link will be invisible but will activate when registrationSuccessful is true
//            NavigationLink(
//                destination: DataConsentView(),
//                isActive: $viewModel.registrationSuccessful,
//                label: { EmptyView() }
//            )
        }
        
        VStack(spacing: 20) {
            Text("Create Account")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            TextField("Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .multilineTextAlignment(.center)
            }
            
            Button(action: {
                Task {
                    await viewModel.signUp()
                }
            }) {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Text("Sign Up")
                }
            }
            .disabled(viewModel.isLoading)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Create Account")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(
                    isPresented: $viewModel.registrationSuccessful,
                    destination: { DataConsentView() }
                )    }
}

#Preview {
    NavigationView {
        SignUpView()
    }
}
