//
//  AffirmationCard.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/2/25.
//
import SwiftUI

// MARK: - Subview of HomeView
struct AffirmationCard: View {
    let affirmation: Affirmation?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("DAILY AFFIRMATION")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.white.opacity(0.8))
                .tracking(1.2)
            
            Text(affirmation?.text ?? "Loading an affirmation...")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
                .lineSpacing(4)
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("OliveGreen"))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
