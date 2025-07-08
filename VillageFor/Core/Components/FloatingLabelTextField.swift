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
    
    // State to control the visibility of the floating label
    @State private var showLabel: Bool

    // MARK: - Initialization
    init(text: Binding<String>, placeholder: String, isSecure: Bool = false) {
        self._text = text
        self.placeholder = placeholder
        self.isSecure = isSecure
        self._showLabel = State(initialValue: !text.wrappedValue.isEmpty)
    }

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            // Conditionally show the label when the text field is not empty
            if showLabel {
                Text(placeholder)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .transition(.opacity)
            }
            
            Group {
                if isSecure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
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
