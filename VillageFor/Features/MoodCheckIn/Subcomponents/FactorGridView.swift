//
//  FactorGridView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/21/25.
//

import SwiftUI

struct FactorGridView: View {
    let allFactors: [String]
    @Binding var selectedFactors: Set<String>
    let toggleAction: (String) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
                ForEach(allFactors, id: \.self) { factor in
                    let isSelected = selectedFactors.contains(factor)
                    
                    Button(action: { toggleAction(factor) }) {
                        HStack(spacing: 6) {
                            Text(factor)
                                .font(.system(size: 14, weight: .medium))
                                .multilineTextAlignment(.center)
                            
                            if isSelected {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color("ThemeGreen"))
                                    .font(.system(size: 14, weight: .semibold))
                                    .transition(.asymmetric(
                                        insertion: .scale.combined(with: .opacity),
                                        removal: .move(edge: .trailing).combined(with: .opacity)
                                    ))
                            }
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, isSelected ? 14 : 12)
                        .frame(height: 36) // Fixed height to prevent clipping
                        .background(
                            Capsule()
                                .fill(isSelected ? Color("ThemeGreen").opacity(0.15) : Color.white)
                                .overlay(
                                    Capsule()
                                        .stroke(isSelected ? Color("ThemeGreen").opacity(0.3) : Color.gray.opacity(0.2), lineWidth: isSelected ? 1.5 : 1)
                                )
                        )
                        .scaleEffect(isSelected ? 1.02 : 1.0) // Reduced scale to prevent clipping
                        .shadow(color: isSelected ? Color("ThemeGreen").opacity(0.15) : Color.black.opacity(0.05),
                                radius: isSelected ? 2 : 1,
                                x: 0,
                                y: 1)
                    }
                    .foregroundColor(.primary)
                    .animation(.spring(response: 0.80, dampingFraction: 0.7, blendDuration: 0), value: isSelected)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .frame(height: 42) // Fixed ScrollView height
    }
}
