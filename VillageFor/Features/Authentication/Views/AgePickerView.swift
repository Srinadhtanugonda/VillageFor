import SwiftUI

struct AgePickerView: View {
    
    @StateObject private var viewModel = AgePickerViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // Header Title
            Text("How old are you?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.bottom, 40)
            
            // Custom Picker Implementation
            GeometryReader { fullGeometry in
                let center = fullGeometry.size.height / 2
                
                ZStack {
                    // This is the light green selection indicator box
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(red: 0.2, green: 0.4, blue: 0.3).opacity(0.1))
                        .frame(height: viewModel.itemHeight)
                    
                    ScrollView {
                        // The list of ages, with padding at top and bottom
                        // to allow the first and last numbers to reach the center.
                        VStack(spacing: 0) {
                            ForEach(viewModel.ageRange, id: \.self) { age in
                                GeometryReader { itemGeometry in
                                    // Calculate the distance of this item from the center of the ScrollView
                                    let distanceFromCenter = abs(center - itemGeometry.frame(in: .global).midY)
                                    
                                    // Calculate opacity and scale based on distance
                                    let opacity = max(0.2, 1.0 - (distanceFromCenter / (center * 0.8)))
                                    let scale = max(0.5, 1.0 - (distanceFromCenter / (center * 1.5)))
                                    
                                    Text("\(age)")
                                        .font(.system(size: 40, weight: .bold))
                                        .foregroundColor(Color(red: 0.2, green: 0.4, blue: 0.3))
                                        .scaleEffect(scale)
                                        .opacity(opacity)
                                }
                                .frame(height: viewModel.itemHeight)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    // This modifier makes the ScrollView snap to the center of each item
                    .scrollTargetBehavior(.viewAligned)
                    // Update the selectedAge when scrolling stops
                    .scrollPosition(id: $viewModel.selectedAge)
                }
            }
            
            Spacer()
            
            // Continue Button
            Button(action: {
                viewModel.continueTapped()
            }) {
                Text("Continue")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 0.2, green: 0.4, blue: 0.3))
                    .foregroundColor(.white)
                    .cornerRadius(24)
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .background(Color(white: 0.97).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AgePickerView()
    }
}