import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var sessionManager: SessionManager

    @Binding var hasCompletedOnboarding: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                Image("build_your_village")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 300)
                    .padding(.horizontal)
                Spacer()
                VStack(spacing: 8) {
                    // If you have a LoginView, it would also need to accept and pass the binding
                    // if it can lead to further onboarding steps for incomplete profiles.
//                    NavigationLink(destination: LoginView(hasCompletedOnboarding: $hasCompletedOnboarding).environmentObject(sessionManager)) {
//                        Text("Log in")
//                    }
//                    .buttonStyle(.secondary)

                    NavigationLink(destination: DataConsentView(hasCompletedOnboarding: $hasCompletedOnboarding).environmentObject(sessionManager)) {
                        Text("Sign up")
                    }
                    .buttonStyle(.primary)
                }.padding(.horizontal, 4)
                .padding(.bottom)
                .background(Color(white: 0.97).ignoresSafeArea())
            }
            .padding(.horizontal, 24)
            .padding(.bottom)
            .background(Color(white: 0.97).ignoresSafeArea())
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    @State var previewHasCompletedOnboarding = false // For preview purposes
    return NavigationStack {
        WelcomeView(hasCompletedOnboarding: $previewHasCompletedOnboarding)
            .environmentObject(SessionManager())
    }
}
