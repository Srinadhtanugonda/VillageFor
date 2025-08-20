//
//  FloatingLabelTextField.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//

import SwiftUI

struct FloatingLabelTextField: View {
    // MARK: - Properties
    
    // A Binding to the text value that will be managed by the parent view
    @Binding var text: String
    let placeholder: String
    
    // to determine if this is a secure field
    var isSecure: Bool = false
    
    // Error message to display below the text field
    var errorMessage: String? = nil
    
    // Callback for when validation should be triggered
    var onValidationNeeded: (() -> Void)? = nil
    
    // State to control the visibility of the floating label
    @State private var showLabel: Bool
    
    // State to track if validation should be shown
    @State private var shouldShowValidation: Bool = false
    
    // State to track if the field has been interacted with
    @State private var hasBeenTouched: Bool = false
    
    @FocusState private var isFocused: Bool

    // MARK: - Initialization
    init(text: Binding<String>, placeholder: String, isSecure: Bool = false, errorMessage: String? = nil, onValidationNeeded: (() -> Void)? = nil) {
        self._text = text
        self.placeholder = placeholder
        self.isSecure = isSecure
        self.errorMessage = errorMessage
        self.onValidationNeeded = onValidationNeeded
        self._showLabel = State(initialValue: !text.wrappedValue.isEmpty)
    }

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            // Conditionally show the label when the text field is not empty
            if showLabel {
                Text(placeholder)
                    .font(.caption)
                    .foregroundColor(Color("NightShade"))
                    .transition(.opacity)
            }
            
            Group {
                if isSecure {
                    SecureField(placeholder, text: $text)
                        .focused($isFocused)
                        .onSubmit {
                            triggerValidation()
                        }
                } else {
                    TextField(placeholder, text: $text)
                        .focused($isFocused)
                        .onSubmit {
                            triggerValidation()
                        }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(shouldShowError ? Color.red : Color.white, lineWidth: shouldShowError ? 1 : 0)
            )
            .onChange(of: text) { newValue in
                // Update showLabel based on whether the text field is empty
                withAnimation(.easeIn(duration: 0.2)) {
                    showLabel = !newValue.isEmpty
                }
                
                // Hide validation when user starts typing again (but only if they've touched the field)
                if shouldShowValidation && hasBeenTouched {
                    shouldShowValidation = false
                }
            }
            .onChange(of: isFocused) { focused in
                if focused {
                    // Mark as touched when user focuses on the field
                    hasBeenTouched = true
                } else {
                    // Trigger validation when user leaves the field (if they've interacted with it)
                    if hasBeenTouched {
                        triggerValidation()
                    }
                }
            }
            
            // Error message display
            if shouldShowError {
                Text(errorMessage!)
                    .font(.caption)
                    .foregroundColor(.red)
                    .padding(.leading, 4)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .frame(minHeight: shouldShowError ? 84 : 64) // Adjust height when error is present
    }
    
    // MARK: - Helper Methods
    
    private func triggerValidation() {
        shouldShowValidation = true
        onValidationNeeded?()
    }
    
    // Computed property to determine if error should be shown
    private var shouldShowError: Bool {
        guard let errorMessage = errorMessage, !errorMessage.isEmpty else { return false }
        return shouldShowValidation
    }
    
    // Public method to force show validation (useful for form submission)
    func showValidation() {
        shouldShowValidation = true
    }
}

