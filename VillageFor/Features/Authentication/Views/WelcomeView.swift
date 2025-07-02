import SwiftUI
import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var sessionManager: SessionManager

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                CurvedText(text: "build your village", radius: 220, kerning: 2)
                
                Spacer()
                VStack(spacing: 8) {
                    NavigationLink(destination: LoginView().environmentObject(sessionManager)) {
                        Text("Log in")
                    }
                    .buttonStyle(.secondary)
                    
                    NavigationLink(destination: DataConsentView().environmentObject(sessionManager)) {
                        Text("Sign up")
                    }
                    .buttonStyle(.primary)
                }.padding(.horizontal, 44)
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
    NavigationStack {
        WelcomeView().environmentObject(SessionManager())
    }
}
