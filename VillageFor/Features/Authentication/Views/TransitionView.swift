import SwiftUI

struct TransitionView: View {
    @State private var navigateToAgePicker = false
    
    // Define the custom green color from your design
    private let backgroundColor = Color("ThemeGreen")
    @EnvironmentObject var sessionManager: SessionManager

    
    var body: some View {
        ZStack {
            // 1. Set the new background color
            backgroundColor.ignoresSafeArea()
            
            // 2. Display the new text
            Text("Answer a few\nquestions to help us\nget to know you...")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
        }
        .navigationBarBackButtonHidden(true)
        // This logic remains the same. It triggers the navigation after 2 seconds.
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.navigateToAgePicker = true
            }
        }
        .navigationDestination(
            isPresented: $navigateToAgePicker,
            destination: { AgePickerView().environmentObject(sessionManager) }
        )
    }
}

#Preview {
    NavigationStack {
        TransitionView().environmentObject(SessionManager())
    }
}
