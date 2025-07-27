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
    @State private var selectedEmotion: String? = nil
    
    init(dailyCheckin: DailyCheckin) {
        _viewModel = StateObject(wrappedValue: SelectEmotionViewModel(dailyCheckin: dailyCheckin))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header Section
            VStack(alignment: .leading, spacing: 16) {
                Text("Describe your emotions")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                Text("Here are words that correspond to a **neutral to positive mood** with **higher energy**. Select the one that feels most like you.")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 32)
            
            // Emotions List - No ScrollView
            VStack(spacing: 12) {
                ForEach(Array(viewModel.emotions.enumerated()), id: \.offset) { index, emotion in
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.dailyCheckin.selectedEmotion = emotion
                            selectedEmotion = emotion
                        }
                        
                        // Navigate after a short delay to show the selection
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            // Navigation logic here - you might want to use a navigation coordinator
                            // or handle navigation in your view model
                        }
                    }) {
                        HStack {
                            Text(emotion)
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            // Show checkmark if this emotion is selected
                            if selectedEmotion == emotion {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.purple)
                                    .transition(.scale.combined(with: .opacity))
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 18)
                        .frame(maxWidth: .infinity)
                        .background(
                            // Enhanced background when selected
                            LinearGradient(
                                colors: [
                                    Color.purple.opacity(0.15 - (Double(index) * 0.015)),
                                    Color.purple.opacity(0.10 - (Double(index) * 0.012))
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .cornerRadius(16)
                        .overlay(
                            // border for selected state
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(
                                    selectedEmotion == emotion ? Color.purple.opacity(0.5) : Color.clear,
                                    lineWidth: 1.5
                                )
                        )
                        .scaleEffect(selectedEmotion == emotion ? 1.0 : 1.0)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
            Spacer()
            
            Button("None of these") {
                dismiss()
            }
            .font(.system(size: 17, weight: .medium))
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.bottom, 14)

            
            Button("Continue") {
                Task {
                    viewModel.continueTapped()
                }
            }
            .buttonStyle(.primary)
            .padding()
        }
        .background(Color(.systemGray6).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar {
            CustomBackButtonToolbar()
            
            // Close button
            ToolbarItem(placement: .navigationBarTrailing) {
                DismissButton()
            }
        }
        .navigationDestination(
            isPresented: $viewModel.shouldNavigateToJournalView
        ) {
            JournalView(dailyCheckin: viewModel.dailyCheckin)
        }
    }
}

//#Preview {
//    let sampleCheckin = DailyCheckin(selectedEmotion: "Astonished", timestamp: .init(date: Date()))
//    
//    return NavigationStack {
//        SelectEmotionView(dailyCheckin: sampleCheckin)
//    }
//}
