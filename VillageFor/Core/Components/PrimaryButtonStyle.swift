//
//  PrimaryButtonStyle.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//


import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    
    // This function styles the button's appearance.
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 18, weight: .semibold))
            .frame(maxWidth: .infinity, minHeight: 56)
            .background(Color("ThemeGreen"))
            .foregroundColor(.white)
            .cornerRadius(28)
            // Add a visual effect for when the button is being pressed.
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}

// This extension makes it easier to call your new style.
extension ButtonStyle where Self == PrimaryButtonStyle {
    /// A reusable style for the app's primary action buttons.
    static var primary: Self {
        return .init()
    }
}