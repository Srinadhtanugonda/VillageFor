//
//  FloatingLabelSecureField.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//


// Example FloatingLabelSecureField (you'd need to create this file)
import SwiftUI

struct FloatingLabelSecureField: View {
    @Binding var text: String
    let placeholder: String
    @State private var showLabel: Bool

    init(text: Binding<String>, placeholder: String) {
        self._text = text
        self.placeholder = placeholder
        self._showLabel = State(initialValue: !text.wrappedValue.isEmpty)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if showLabel {
                Text(placeholder)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .transition(.opacity)
            }
            SecureField(placeholder, text: $text) // Key change: SecureField
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3), lineWidth: 1))
                .onChange(of: text) { newValue in
                    withAnimation(.easeIn(duration: 0.2)) {
                        showLabel = !newValue.isEmpty
                    }
                }
        }
    }
}