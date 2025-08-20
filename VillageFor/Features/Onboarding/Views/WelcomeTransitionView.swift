//
//  WelcomeTransitionView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 8/12/25.
//


import SwiftUI

struct WelcomeTransitionView: View {
    @Binding var hasCompletedOnboarding: Bool
    
    // State properties to control the animations
    @State private var showWelcome = false
    @State private var showKindWords = false

    var body: some View {
        ZStack {
            Color("ThemeGreen").ignoresSafeArea()

            // 1. "Welcome to the village" section
            VStack(spacing: 20) {
                Image("Splash_logo") // Assumes this image is in your assets
                    .resizable().scaledToFit().frame(width: 80, height: 80)
                Image("Welcome_to_the_Village")
            }
            .foregroundColor(.white)
            .opacity(showWelcome ? 1 : 0)

            // 2. "KIND WORDS" section
            VStack(spacing: 10) {
                Text("KIND WORDS").font(.title).fontWeight(.bold)
                Rectangle().frame(width: 200, height: 1)
                Text("I am capable of amazing things").font(.title3)
            }
            .foregroundColor(.white)
            .opacity(showKindWords ? 1 : 0)
        }
        .onAppear(perform: startAnimationSequence)
    }

    private func startAnimationSequence() {
        // Fade in the "Welcome" message
        withAnimation(.easeInOut(duration: 1.5)) {
            showWelcome = true
        }

        // After 3 seconds, cross-fade to "Kind Words"
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            withAnimation(.easeInOut(duration: 1.5)) {
                showWelcome = false
                showKindWords = true
            }
        }
        
        // After 6 seconds total, finish onboarding
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
            hasCompletedOnboarding = true
        }
    }
}


// MARK: - Previews
struct WelcomeTransitionView_Previews: PreviewProvider {
    static var previews: some View { //This allows the preview canvas to render the view and see the animation.
        WelcomeTransitionView(hasCompletedOnboarding: .constant(false))
    }
}
