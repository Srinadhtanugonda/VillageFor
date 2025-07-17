//
//  MoodCheckinView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/8/25.
//


import SwiftUI

struct MoodCheckinView: View {
    
    @StateObject private var viewModel = MoodCheckinViewModel()
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var sessionManager: SessionManager
    @State private var feelingLevel: Double = 65

    var body: some View {
        VStack(alignment: .center) {
            Text("How do you feel today?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)
                .alignmentGuide(.leading) { $0[VerticalAlignment.top] }
            
            Spacer()
          
                CustomVerticalSlider(
                    value: $feelingLevel,
                    range: 0...100,
                    topLabel: "Positive",
                    bottomLabel: "Negative",
                    height: 400,
                    width: 20
                )
                .frame(maxHeight: 400)
            
            
            Spacer()
            Spacer()
            
            Button("Continue") {
                Task {
                    await viewModel.saveMoodEntry()
                    dismiss()
                }
            }
            .buttonStyle(.primary)
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
        MoodCheckinView().environmentObject(SessionManager())
    }
}
