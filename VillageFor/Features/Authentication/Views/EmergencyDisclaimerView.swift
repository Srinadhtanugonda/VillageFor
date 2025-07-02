//
//  EmergencyDisclaimerView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//


import SwiftUI

struct EmergencyDisclaimerView: View {
    
    @StateObject private var viewModel = EmergencyDisclaimerViewModel()
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var sessionManager: SessionManager
    
    private let backgroundColor = Color("ThemeGreen")
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                backgroundColor.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 16) {
                    // ... all your existing VStack content ...
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Is this an emergency?")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("We want to help, but we're not an emergency service. Select yes if:")
                            .font(.subheadline)
                    }
                    .padding(.bottom, 20)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Image(systemName: "arrow.right")
                            Text("You are currently experiencing a mental health crisis")
                        }
                        HStack {
                            Image(systemName: "arrow.right")
                            Text("You are in need of immediate help")
                        }
                    }
                    .font(.headline)
                    .fontWeight(.regular)
                    
                    Spacer()
                    
                    Text("not alone . you are not alone")
                        .font(.title)
                        .fontWeight(.light)
                        .opacity(0.3)
                        .padding(.bottom, 20)
                    
                    VStack(spacing: 12) {
                        Button("Yes") {
                            viewModel.yesButtonTapped()
                        }
                        .buttonStyle(.secondary) // Use your reusable style
                        
                        Button("No") {
                            viewModel.noButtonTapped()
                        }
                        .buttonStyle(.secondary)
                    }
                }
                .foregroundColor(.white)
                .padding()
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                CustomBackButtonToolbar()
            }
            .navigationDestination(
                isPresented: $viewModel.shouldNavigateToNextStep,
                destination: {
                    CreateProfileView()
                        .environmentObject(sessionManager)
                }
            )
        }
    }
}
#Preview {
    NavigationStack {
        EmergencyDisclaimerView().environmentObject(SessionManager())
    }
}
