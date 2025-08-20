import SwiftUI

struct TransitionView<Content: View, Destination: View>: View {
    @State private var navigateToDestination = false

    let content: Content

    let destination: Destination


    @Binding var hasCompletedOnboarding: Bool

    private let backgroundColor = Color("ThemeGreen")
    @EnvironmentObject var sessionManager: SessionManager

    init(destination: Destination, hasCompletedOnboarding: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.destination = destination
        self._hasCompletedOnboarding = hasCompletedOnboarding
        self.content = content()
    }

    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()

            content // Displaying the custom content
                .padding()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.navigateToDestination = true
            }
        }
        .navigationDestination(
            isPresented: $navigateToDestination,
            destination: {
                destination
                    .environmentObject(sessionManager)
            }
        )
    }
}

struct TransitionView_Previews: PreviewProvider {
    static var previews: some View {
        @State var previewHasCompletedOnboarding = false // For preview purposes

        NavigationStack {
            TransitionView(destination: AgePickerView(hasCompletedOnboarding: $previewHasCompletedOnboarding), hasCompletedOnboarding: $previewHasCompletedOnboarding) {
                Image(systemName: "hand.wave.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.white)
                Text("Answer a few\nquestions to help us\nget to know you...")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            .environmentObject(SessionManager())
        }
    }
}
