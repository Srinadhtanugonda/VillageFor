import Foundation

@MainActor
class EmergencyDisclaimerViewModel: ObservableObject {
    
    func yesButtonTapped() {
        // IMPORTANT: In a real app, this should immediately direct the user
        // to emergency resources. For example, by showing a special view
        // with phone numbers like 911, the National Suicide Prevention Lifeline (988),
        // or by attempting to dial the number.
        print("YES tapped: Show emergency resources now.")
        // For now, we'll just print, but this is a critical safety feature.
    }
    
    func noButtonTapped() {
        // If the user selects "No", they can continue into the main app.
        // Here you would likely dismiss the entire authentication flow.
        print("NO tapped: Proceeding to main app.")
    }
}