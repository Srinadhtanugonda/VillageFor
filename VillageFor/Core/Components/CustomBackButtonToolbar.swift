import SwiftUI

/// A reusable toolbar component that displays a custom back button.
struct CustomBackButtonToolbar: ToolbarContent {
    
    // We need to get the dismiss action from the view that uses this component.
    @Environment(\.dismiss) private var dismiss
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
                // When tapped, call the dismiss action.
                dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.primary)
            }
        }
    }
}