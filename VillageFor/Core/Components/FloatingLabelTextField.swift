import SwiftUI

struct FloatingLabelTextField: View {
    // MARK: - Properties

    // A Binding to the text value that will be managed by the parent view
    @Binding var text: String
    // The placeholder text when the field is empty
    let placeholder: String
    // State to control the visibility of the floating label
    @State private var showLabel: Bool

    // MARK: - Initialization

    // Initialize with a binding for text, a placeholder string,
    // and an optional initial state for showLabel (defaults to false)
    init(text: Binding<String>, placeholder: String) {
        self._text = text // Bind the text
        self.placeholder = placeholder
        // Initialize showLabel based on the initial value of the text binding
        self._showLabel = State(initialValue: !text.wrappedValue.isEmpty)
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            // Conditionally show the label when the text field is not empty
            if showLabel {
                Text(placeholder) // Use the placeholder as the label text
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .transition(.opacity) // Optional: Add a fade transition
            }

            TextField(placeholder, text: $text)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3), lineWidth: 1))
                .onChange(of: text) { newValue in
                    // Update showLabel based on whether the text field is empty
                    withAnimation(.easeIn(duration: 0.2)) {
                        showLabel = !newValue.isEmpty
                    }
                }
        }
    }
}

// MARK: - Preview Provider (for easy testing in Canvas)
struct FloatingLabelTextField_Previews: PreviewProvider {
    // Create a dummy state variable for the preview
    @State static var previewText: String = ""

    static var previews: some View {
        VStack(spacing: 20) {
            FloatingLabelTextField(text: $previewText, placeholder: "First Name")
                .padding(.horizontal)

            FloatingLabelTextField(text: .constant("Pre-filled Name"), placeholder: "Last Name")
                .padding(.horizontal)

            FloatingLabelTextField(text: .constant("test@example.com"), placeholder: "Email Address")
                .padding(.horizontal)
        }
        .previewLayout(.sizeThatFits)
        .background(Color.gray.opacity(0.1))
    }
}