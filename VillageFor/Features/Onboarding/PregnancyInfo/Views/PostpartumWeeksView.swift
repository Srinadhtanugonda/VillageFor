//
//  PostpartumWeeksView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/31/25.
//

import SwiftUI

struct PostpartumWeeksView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var sessionManager: SessionManager
    
    @ObservedObject var onboardingData: OnboardingData
    @Binding var hasCompletedOnboarding: Bool
    
    @StateObject private var viewModel = PostpartumWeeksViewModel()
    
    // State variables for the three pickers
    @State private var selectedYears: Int? = 0
    @State private var selectedMonths: Int? = 0
    @State private var selectedDays: Int? = 0
    
    private let itemHeight: CGFloat = 74
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
    
    // Data ranges
    private let yearsRange = Array(0...2) // 0-2 years postpartum
    private let monthsRange = Array(0...12) // 0-12 months
    private let daysRange = Array(0...31) // 0-31 days
    
    var body: some View {
        VStack(spacing: 0) {
            Text("How far postpartum\nare you?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color("ThemeGreen").opacity(0.1))
                    .frame(height: itemHeight)
                    .padding(.horizontal)
                
                // Three-column picker
                HStack(spacing: 0) {
                    // Years Picker
                    createPickerColumn(
                        data: yearsRange,
                        selection: $selectedYears,
                        formatValue: { "\($0)" },
                        label: "year\(selectedYears == 1 ? "" : "s")"
                    )
                    .frame(maxWidth: .infinity)
                    
                    // Months Picker
                    createPickerColumn(
                        data: monthsRange,
                        selection: $selectedMonths,
                        formatValue: { "\($0)" },
                        label: "month\(selectedMonths == 1 ? "" : "s")"
                    )
                    .frame(maxWidth: .infinity)
                    
                    // Days Picker
                    createPickerColumn(
                        data: daysRange,
                        selection: $selectedDays,
                        formatValue: { "\($0)" },
                        label: "day\(selectedDays == 1 ? "" : "s")"
                    )
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.top, 10)
            }
            
            Spacer()
            
            Button("Continue") {
                // Convert to weeks and update viewModel
                onboardingData.postpartumWeeks = calculateTotalWeeks()
                viewModel.handleSelection()
            }
            .buttonStyle(.primary)
            .padding(.horizontal, 24)
        }
        .padding(.vertical)
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar {
            CustomBackButtonToolbar()
        }
        .navigationDestination(
            isPresented: $viewModel.navigateToFirstPostpartumExperience,
            destination: {
                FirstPostpartumExperienceView(onboardingData: onboardingData, hasCompletedOnboarding: $hasCompletedOnboarding)
                    .environmentObject(sessionManager)
            }
        )
    }
    
    // Helper function to create a picker column
    @ViewBuilder
    private func createPickerColumn<T: Hashable>(
        data: [T],
        selection: Binding<T?>,
        formatValue: @escaping (T) -> String,
        label: String
    ) -> some View {
        ZStack {
            // Selection indicator background with label inside
            ZStack {
              
                
                // Label positioned on the right side of the selection area
                HStack {
                    Spacer()
                    Text(label)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color("ThemeGreen"))
                        .padding(.trailing, (label == "year" || label == "years") ? 35 : 14) // Conditional padding
                        .offset(y: 2)
                }
            }
            
            // ScrollView with numbers
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    // Top padding
                    let padding = (itemHeight * 7 / 2) - (itemHeight / 2)
                    Color.clear.frame(height: padding)
                    
                    ForEach(data, id: \.self) { item in
                        GeometryReader { geo in
                            let frame = geo.frame(in: .global)
                            let midY = UIScreen.main.bounds.midY
                            let distanceFromCenter = abs(frame.midY - midY)
                            
                            // Calculate scale and opacity based on distance from center
                            let scale = max(0.7, 1 - (distanceFromCenter / (midY * 0.8)))
                            let opacity = max(0.3, 1 - (distanceFromCenter / (midY * 0.6)))
                            
                            HStack {
                                Text(formatValue(item))
                                    .font(.system(size: 40, weight: .bold))
                                    .scaleEffect(x: scale, y: scale)
                                    .opacity(opacity)
                                    .foregroundColor(Color("ThemeGreen"))
                                Spacer()
                            }
                            .padding(.leading, 10)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .frame(height: itemHeight)
                        .id(item)
                    }
                    
                    Color.clear.frame(height: padding)
                }
                .scrollTargetLayout()
            }
            .scrollPosition(id: selection, anchor: .center)
            .onChange(of: selection.wrappedValue) { _, _ in
                feedbackGenerator.impactOccurred()
            }
            
            // Gradient overlays for fade effect
            VStack {
                LinearGradient(
                    colors: [Color(UIColor.systemGray6), .clear],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: itemHeight * 1.5)
                
                Spacer()
                
                LinearGradient(
                    colors: [.clear, Color(UIColor.systemGray6)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: itemHeight * 1.5)
            }
            .allowsHitTesting(false)
        }
        .frame(height: itemHeight * 7) // Show 5 items
        .clipped()
    }
    
    // Calculate total weeks from years, months, and days
    private func calculateTotalWeeks() -> Int {
        let years = selectedYears ?? 0
        let months = selectedMonths ?? 0
        let days = selectedDays ?? 0
        
        // Convert to approximate weeks
        // 1 year ≈ 52 weeks, 1 month ≈ 4.3 weeks, 1 day ≈ 1/7 weeks
        let totalWeeks = (years * 52) + Int(Double(months) * 4.3) + (days / 7)
        return totalWeeks
    }
}

// MARK: - Previews
struct PostpartumWeeksView_Previews: PreviewProvider {
    static var previews: some View {
        @State var previewHasCompletedOnboarding = false
        
        NavigationStack {
            PostpartumWeeksView(
                onboardingData: OnboardingData(),
                hasCompletedOnboarding: $previewHasCompletedOnboarding
            )
            .environmentObject(SessionManager())
        }
    }
}
