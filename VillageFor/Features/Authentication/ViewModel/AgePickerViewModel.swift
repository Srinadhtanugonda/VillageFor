import Foundation
import SwiftUI // Import SwiftUI for CGFloat

@MainActor
class AgePickerViewModel: ObservableObject {
    
    let ageRange = 18...100
    @Published var selectedAge = 34 // Set default to match design
    
    // The height of each row in our picker.
    let itemHeight: CGFloat = 50 
    
    func continueTapped() {
        print("User selected age: \(selectedAge). Onboarding complete!")
        // Here you would save the age and dismiss the auth flow.
    }
}