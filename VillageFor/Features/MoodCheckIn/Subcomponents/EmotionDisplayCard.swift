//
//  EmotionDisplayCard.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/21/25.
//

import SwiftUI

// MARK: - Subviews
struct EmotionDisplayCard: View {
    let emotion: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                Text(emotion.uppercased())
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .opacity(0.9)
                
                // Simple smiley face icon to match Figma
                Image(systemName: "face.smiling")
                    .font(.system(size: 50, weight: .light))
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            // Decorative pattern on the right (optional)
//            VStack {
//                ForEach(0..<4, id: \.self) { row in
//                    HStack {
//                        ForEach(0..<4, id: \.self) { col in
//                            Circle()
//                                .fill(.white.opacity(0.1))
//                                .frame(width: 8, height: 8)
//                        }
//                    }
//                }
//            }
//            .padding(.trailing, 8)
        }
        .padding(24)
        .frame(height: 140)
        .background(
            LinearGradient(
                colors: [Color.purple.opacity(0.8), Color.purple.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(24)
        .shadow(color: .purple.opacity(0.2), radius: 8, x: 0, y: 4)
    }
}
