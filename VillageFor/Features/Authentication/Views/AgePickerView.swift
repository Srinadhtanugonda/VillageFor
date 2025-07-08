import SwiftUI

struct AgePickerView: View {
    @StateObject private var viewModel = AgePickerViewModel()
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var sessionManager: SessionManager
    
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        VStack(spacing: 0) {
            Text("How old are you?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Spacer()
            
            Text("Debug: Selected Age is \(viewModel.selectedAge ?? 0)")
                .font(.caption)
                .foregroundColor(.red)
                .padding(.top, 5)

            
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
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                            .frame(height: viewModel.itemHeight)
                            .id(age)
                        }
                        
                        Color.clear.frame(height: padding)
                    }
                    .scrollTargetLayout()
                }
                .scrollPosition(id: $viewModel.selectedAge, anchor: .center)
                .onChange(of: viewModel.selectedAge) { _, _ in
                                    feedbackGenerator.impactOccurred()
                                }
                
                // Layer 3: The gradient overlays for the fade effect
                VStack {
                    LinearGradient(colors: [Color(UIColor.systemGray6), .clear], startPoint: .top, endPoint: .bottom)
                        .frame(height: viewModel.itemHeight * 2)
                    Spacer()
                    LinearGradient(colors: [.clear, Color(UIColor.systemGray6)], startPoint: .top, endPoint: .bottom)
                        .frame(height: viewModel.itemHeight * 2)
                }
                .allowsHitTesting(false) // Let touches pass through the gradient
            }
            .frame(height: viewModel.itemHeight * 7) // Show 7 items at a time
            .clipped()
            
            Spacer()
            
            Button("Continue") {
                Task {
                    await viewModel.continueTapped(sessionManager: sessionManager)
                }
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
    }
}


#Preview {
    NavigationStack {
        AgePickerView().environmentObject(SessionManager())
    }
}


//            ScrollViewReader { proxy in
//                ScrollView(.vertical, showsIndicators: false) {
//                    LazyVStack(spacing: 5) {
//                        Color.clear.frame(height: 280)
//
//                        ForEach(viewModel.ageRange, id: \.self) { age in
//                            GeometryReader { geo in
//                                let distance = abs(geo.frame(in: .global).midY - UIScreen.main.bounds.height / 2)
//                                let isSelected = age == (viewModel.selectedAge ?? 0)
//                                let opacity = max(0.3, 1.2 - distance / 160)
//                                let fontSize: CGFloat = isSelected ? 50 : max(24, 48 - distance / 14)
//
//                                Text("\(age)")
//                                    .font(.system(size: fontSize, weight: .medium))
//                                    .foregroundColor(Color("ThemeGreen"))
//                                    .opacity(opacity)
//                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                                    .background(
//                                        RoundedRectangle(cornerRadius: 30)
//                                            .fill(Color("ThemeGreen").opacity(0.1))
//                                            .opacity(isSelected ? 1 : 0)
//                                    )
//                            }
//                            .frame(height: 70)
//                            .id(age)
//                        }
//                        Color.clear.frame(height: 200)
//                    }.scrollTargetLayout()
//                }.scrollTargetBehavior(.viewAligned)
//                    .scrollPosition(id: $viewModel.selectedAge)
//                    .onAppear {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                            proxy.scrollTo(34, anchor: .center)
//                        }
//                    }
//                    .onChange(of: viewModel.selectedAge) { oldValue, newValue in
//                        print("ViewModel selectedAge changed: \(oldValue) -> \(newValue)")
//                    }
//            }
//            .frame(height: 480)
//            .clipped()
