//
//  SelectEmotionView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/19/25.
//


import SwiftUI

struct SelectEmotionView: View {
    
    @StateObject private var viewModel: SelectEmotionViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(dailyCheckin: DailyCheckin) {
        _viewModel = StateObject(wrappedValue: SelectEmotionViewModel(dailyCheckin: dailyCheckin))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Describe your emotions")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 8)
            
            Text("Here are words that correspond to a **neutral to positive mood** with **higher energy**. Select the one that feels most like you.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 30)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.emotions, id: \.self) { emotion in
                        // When an emotion is tapped, we navigate to the JournalView,
                        // passing the updated check-in object along.
//                        NavigationLink(destination: JournalView(dailyCheckin: updatedCheckin(with: emotion))) {
//                            Text(emotion)
//                                .fontWeight(.semibold)
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                                .padding()
//                                .background(Color.purple.opacity(0.1))
//                                .cornerRadius(16)
//                                .foregroundColor(.primary)
//                        }
                    }
                }
            }
            
            Spacer()
            
            Button("None of these") {
                // Handle this case - perhaps navigate directly to the journal
                // without a pre-selected emotion.
                dismiss()
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar {
            CustomBackButtonToolbar()
            // ... Close button ...
        }
    }
    
    // A helper function to create an updated check-in object for the next screen
    private func updatedCheckin(with emotion: String) -> DailyCheckin {
        var checkin = viewModel.dailyCheckin
        checkin.selectedEmotion = emotion
        return checkin
    }
}
