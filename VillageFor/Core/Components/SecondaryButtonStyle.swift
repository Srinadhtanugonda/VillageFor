import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 18, weight: .semibold))
            .frame(maxWidth: .infinity, minHeight: 56)
            .background(Color.white)
            .foregroundColor(Color("ThemeGreen"))
            .cornerRadius(28)
            // Add the thin border
            .overlay(
                RoundedRectangle(cornerRadius: 28)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
            // Add a visual effect for when the button is being pressed
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}

// Convenience extension to make calling the style easier
extension ButtonStyle where Self == SecondaryButtonStyle {
    /// A reusable style for secondary action buttons.
    static var secondary: Self {
        return .init()
    }
}