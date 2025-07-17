//
//  EnergyLevelView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/8/25.
//


import SwiftUI

struct EnergyLevelView: View {
    
    // 1. Use the new ViewModel
    @StateObject private var viewModel = EnergyLevelViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var feelingLevel: Double = 65

    var body: some View {
        VStack(alignment: .center) {
            Text("How are your energy levels?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)
                .alignmentGuide(.leading) { $0[VerticalAlignment.top] }
            
            Spacer()
            
            CustomVerticalSlider(
                value: $feelingLevel,
                range: 0...100,
                topLabel: "A lot of energy",
                bottomLabel: "No energy",
                height: 400,
                width: 20
            )
            .frame(maxHeight: 400)

            Spacer()
            Spacer()

            
            Button("Continue") {
                Task {
                    await viewModel.saveEnergyLevelEntry()
                    dismiss()
                }
            }
            .buttonStyle(.primary)
            .padding(.horizontal, 24) // Add padding to the button
        }
        .padding()
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar {
            CustomBackButtonToolbar()
            // ... trailing close button ...
        }
    }
}

#Preview {
    NavigationStack {
        EnergyLevelView()
    }
}

