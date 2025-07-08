//
//  ActionCard.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/2/25.
//

import SwiftUI

// MARK: - Subview of HomeView
struct ActionCard: View {
    let title: String
    let subtitle: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 20) {
                Spacer()

                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .tracking(1.0)
                    .multilineTextAlignment(.center)
                
                // Arrow button
                Button(action: action) {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(Color("ThemeGreen"))
                        .clipShape(Circle())
                }
                
                Spacer()
                
                    Text(subtitle)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .background(Color("LightBeige"))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
