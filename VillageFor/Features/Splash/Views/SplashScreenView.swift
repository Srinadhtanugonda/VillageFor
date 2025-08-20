//
//  SplashScreenView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/24/25.
//

import SwiftUI

struct SplashScreenView: View {
    
    // to control the rotation of the entire circle of text
    @State private var rotationAngle: Double = 0.0
    //to control opacity of image and text
    @State private var contentOpacity: Double = 1.0
    

    let text = " V I L L A G E F O R" + "      " + " V I L L A G E F O R" + "      "
    private var characters: [Character] {
        Array(text)
    }
    
    var body: some View {
        ZStack {
            Color("ThemeGreen").ignoresSafeArea()
            
            Image("Splash_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .opacity(contentOpacity)
            
            // The rotating text circle
            ZStack {
                // Loop over each character to place it on the circle
                ForEach(characters.indices, id: \.self) { index in
                    let character = characters[index]
                    
                    // Calculating the angle for this character
                    let angle = Double(index) * (360.0 / Double(characters.count))
                    
                    Text(String(character))
                        .font(.system(size: 22, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                        // Increase the radius - more distance from center
                        .offset(y: -130)
                        // Rotate the character into its position on the circle
                        .rotationEffect(.degrees(angle))
                }
            }
            // Apply the continuous rotation animation to the entire ZStack
            .rotationEffect(.degrees(rotationAngle))
            .opacity(contentOpacity)
        }
        .onAppear {
            // Starting the rotation animation when the view appears
            withAnimation(.linear(duration: 2.0)) {
                rotationAngle = 120 // Quarter rotation to align text properly
            }
            
            // After 2.5 seconds, start the slow fade out
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.easeOut(duration: 1.0)) {
                    contentOpacity = 0.0
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
