import SwiftUI

struct CurvedText: View {
    let text: String
    let radius: Double
    let kerning: Double
    
    // 1. We need to split the text into an array of characters so we can loop over it.
    private var characters: [Character] {
        Array(text)
    }
    
    var body: some View {
        ZStack {
            // 2. Loop over each character and its index.
            ForEach(characters.indices, id: \.self) { index in
                // 3. Get the character itself.
                let character = characters[index]
                
                // --- The Math for Positioning and Rotating ---
                
                // 4. Calculate the total angle needed for all characters based on the kerning.
                // Kerning is the angle (in degrees) between the centers of each character.
                let totalAngle = Double(characters.count - 1) * kerning
                
                // 5. Calculate the starting angle. To center the text, we start at -90 degrees
                // (the top of the circle) and go back by half of the total angle.
                let startAngle = -90.0 - (totalAngle / 2.0)
                
                // 6. Calculate the angle for the current character.
                let characterAngle = startAngle + (kerning * Double(index))
                
                // 7. Calculate the (x, y) position of the character on the circle's edge.
                // We need to convert our degrees to radians for the sin/cos functions.
                let xOffset = radius * cos(characterAngle * .pi / 180.0)
                let yOffset = radius * sin(characterAngle * .pi / 180.0)
                
                // 8. The rotation angle for the character is its angle on the circle plus 90 degrees
                // to make it stand upright.
                let rotation = Angle(degrees: characterAngle + 90)
                
                // --- Applying the Modifiers ---
                
                Text(String(character))
                    .font(.system(size: 34, weight: .bold, design: .serif))
                    .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.3))
                    .offset(x: xOffset, y: yOffset)
                    .rotationEffect(rotation)
            }
        }
        // We wrap the ZStack in another view to apply a fixed frame,
        // ensuring the curve's center stays in the middle of the view.
        .frame(width: radius * 2, height: radius * 2)
    }
}

#Preview {
    // You can adjust the radius and kerning here to test different looks!
    CurvedText(text: "build your village", radius: 180, kerning: 11)
}