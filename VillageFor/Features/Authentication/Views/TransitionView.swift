import SwiftUI

struct TransitionView: View {
    @State private var navigateToAgePicker = false
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Welcome to the village!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            ProgressView() // This shows a spinning activity indicator
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.5) // Make it a bit larger
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        // This modifier triggers an action when the view appears
        .onAppear {
            // Wait for 2 seconds, then set the state to trigger navigation
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.navigateToAgePicker = true
            }
        }
        // This navigation destination listens for the state change
        .navigationDestination(
            isPresented: $navigateToAgePicker,
            destination: { AgePickerView() }
        )
    }
}

#Preview {
    NavigationStack {
        TransitionView()
    }
}