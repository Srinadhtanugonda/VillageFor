//
//  HeaderView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/2/25.
//


import SwiftUI

// MARK: - Subview of HomeView
struct HeaderView: View {
    let userName: String
    let signOutAction: () -> Void
    
    var body: some View {
        HStack {
            Text("Hi, \(userName)")
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(.primary)
                .accessibilityIdentifier("WelcomeUserNameTextFieldInHeader")
            
            Spacer()
            
            Button(action: signOutAction) {
                Text("Sign Out")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color("ThemeGreen"))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
            }
        }
        .padding(.top, 8)
    }
}
