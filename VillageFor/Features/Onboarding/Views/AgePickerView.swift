//
//  AgePickerView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//

import SwiftUI

struct AgePickerView: View {
    @StateObject private var viewModel: AgePickerViewModel

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var sessionManager: SessionManager

    @Binding var hasCompletedOnboarding: Bool

    init(hasCompletedOnboarding: Binding<Bool>) {
        self._hasCompletedOnboarding = hasCompletedOnboarding
        self._viewModel = StateObject(wrappedValue: AgePickerViewModel(hasCompletedOnboarding: hasCompletedOnboarding))
    }

    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)

    var body: some View {
        VStack(spacing: 0) {
            Text("How old are you?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            Spacer()

            // Custom Picker UI
            ZStack {
                // Layer 1: The selection indicator in the background
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color("ThemeGreen").opacity(0.1))
                    .frame(height: viewModel.itemHeight)

                // Layer 2: The ScrollView with the numbers
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        // Padding to allow the first and last items to be centered
                        // Adjust the 7 here if you change the number of visible items in the .frame(height:) below
                        let padding = (viewModel.itemHeight * 7 / 2) - (viewModel.itemHeight / 2)
                        Color.clear.frame(height: padding)

                        ForEach(viewModel.ageRange, id: \.self) { age in
                            GeometryReader { geo in
                                let frame = geo.frame(in: .global)
                                // Get the center of the entire screen
                                let midY = UIScreen.main.bounds.midY
                                let distanceFromCenter = abs(frame.midY - midY)

                                // Calculate scale and opacity based on distance from center
                                let scale = max(0.7, 1 - (distanceFromCenter / (midY)))
                                let opacity = max(0.2, 1 - (distanceFromCenter / (midY * 0.8)))

                                Text("\(age)")
                                    .font(.system(size: 60, weight: .bold))
                                    .scaleEffect(x: scale, y: scale)
                                    .opacity(opacity)
                                    .foregroundColor(Color("ThemeGreen"))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity) // Make text fill its frame
                            }
                            .frame(height: viewModel.itemHeight) // Each row has a fixed height
                            .id(age) // Essential for scrollPosition to track the selected item
                        }

                        Color.clear.frame(height: padding)
                    }
                    .scrollTargetLayout() // Important for scrollPosition to snap to items
                }
                .scrollPosition(id: $viewModel.selectedAge, anchor: .center) // Bind to viewModel.selectedAge
                .onChange(of: viewModel.selectedAge) { _, _ in
                    feedbackGenerator.impactOccurred() // Provide haptic feedback on scroll stop
                }

                // Layer 3: The gradient overlays for the fade effect
                VStack {
                    LinearGradient(colors: [Color(UIColor.systemGray6), .clear], startPoint: .top, endPoint: .bottom)
                        .frame(height: viewModel.itemHeight * 2) // Fade over 2 items
                    Spacer()
                    LinearGradient(colors: [.clear, Color(UIColor.systemGray6)], startPoint: .top, endPoint: .bottom)
                        .frame(height: viewModel.itemHeight * 2) // Fade over 2 items
                }
                .allowsHitTesting(false) // Let touches pass through to the ScrollView
            }
            .frame(height: viewModel.itemHeight * 7) // Explicitly show 7 items (3 above, 1 selected, 3 below)
            .clipped() // Clip content outside this frame

            Spacer()

            Button("Continue") {
                Task {
                    // Call the ViewModel's method, passing the sessionManager
                    // The selectedAge is already bound to viewModel.selectedAge
                    await viewModel.continueTapped(sessionManager: sessionManager)
                }
            }
            .buttonStyle(.primary)
            .padding(.horizontal, 24)
            .navigationDestination(
                isPresented: $viewModel.navigateToNotificationsScreen,
                destination: {
                    PregnantQuestionView(hasCompletedOnboarding: $hasCompletedOnboarding)
                                            .environmentObject(sessionManager) // Pass the existing sessionManager
                }
            )
        }
        .padding(.vertical)
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar {
            CustomBackButtonToolbar()
        }
    }
}

// MARK: - Previews
struct AgePickerView_Previews: PreviewProvider {
    static var previews: some View {
        // For preview, we need to create a @State variable to act as the binding source
        @State var previewHasCompletedOnboarding = false

        NavigationStack {
            // Instantiate AgePickerView, passing the preview binding
            AgePickerView(hasCompletedOnboarding: $previewHasCompletedOnboarding)
                .environmentObject(SessionManager()) // Provide a SessionManager for the preview
        }
    }
}
