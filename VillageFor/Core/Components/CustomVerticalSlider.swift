import SwiftUI

struct CustomVerticalSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let topLabel: String
    let bottomLabel: String
    let trackColor: Color
    let thumbColor: Color
    let height: CGFloat
    let width: CGFloat

    @State private var dragOffset: CGFloat = 0
    @State private var isDragging: Bool = false

    // We'll calculate this internally now based on the value
    @State private var currentHeight: CGFloat = 0

    init(
        value: Binding<Double>,
        range: ClosedRange<Double> = 0...100,
        topLabel: String = "Positive",
        bottomLabel: String = "Negative",
        trackColor: Color = Color(red: 0.9, green: 0.9, blue: 0.82), // Light yellow
        thumbColor: Color = Color(red: 0.6, green: 0.6, blue: 0.2), // Dark olive
        height: CGFloat = 300,
        width: CGFloat = 12 // Thinner width like the image
    ) {
        self._value = value
        self.range = range
        self.topLabel = topLabel
        self.bottomLabel = bottomLabel
        self.trackColor = trackColor
        self.thumbColor = thumbColor
        self.height = height
        self.width = width
    }

    var body: some View {
        VStack(spacing: 16) {
            // Top label
            Text(topLabel)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)
            Spacer()

            ZStack(alignment: .bottom) {
                // Background Track
                Capsule()
                    .frame(width: width, height: height)
                    .foregroundColor(trackColor)

                // Filled portion of the track
                Capsule()
                    .frame(width: width, height: currentHeight)
                    .foregroundColor(thumbColor)

                // Draggable Circle Thumb
                Circle()
                    .fill(thumbColor)
                    .frame(width: width * 2, height: width * 2) // Thumb is larger than track
                    .shadow(color: .black.opacity(0.15), radius: 2, y: 1)
                    .scaleEffect(isDragging ? 1.15 : 1.0)
                    .offset(y: -currentHeight + (width * 2.5) / 2) // Position at the top of the fill
                    .animation(.easeInOut(duration: 0.15), value: isDragging)

            }
            .frame(height: height)
            .contentShape(Rectangle()) // Makes the whole ZStack area draggable
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gestureValue in
                        isDragging = true
                        
                        // Calculate the new height based on drag
                        let newHeight = height - gestureValue.location.y
                        
                        // Clamp the value within the bounds of the slider height
                        let clampedHeight = min(height, max(0, newHeight))
                        
                        // Update the bound value
                        updateValue(from: clampedHeight)
                    }
                    .onEnded { _ in
                        isDragging = false
                    }
            )
            .onChange(of: value) {
                // Update slider height when the value changes from outside
                updateSliderPosition(from: value)
            }
            .onAppear {
                // Initialize slider height from the initial value
                updateSliderPosition(from: value)
            }

            Spacer()

            // Bottom label
            Text(bottomLabel)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)
        }
    }

    private func updateValue(from height: CGFloat) {
        let normalizedHeight = min(max(0, height / self.height), 1)
        let newValue = range.lowerBound + (range.upperBound - range.lowerBound) * normalizedHeight
        self.value = newValue
    }
    
    private func updateSliderPosition(from value: Double) {
        let normalizedValue = (value - range.lowerBound) / (range.upperBound - range.lowerBound)
        currentHeight = self.height * normalizedValue
    }
}
