import SwiftUI

struct CreateProfileView: View {
    
    @StateObject private var viewModel = CreateProfileViewModel()
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Welcome to \nVillageFor")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            VStack(spacing: 25) {
                FloatingLabelTextField(text: $viewModel.firstName, placeholder: "First name")
                FloatingLabelTextField(text: $viewModel.lastName, placeholder: "Last name")
                FloatingLabelTextField(text: $viewModel.email, placeholder: "Email address")
                FloatingLabelSecureField(text: $viewModel.password, placeholder: "Password")
                FloatingLabelTextField(text: $viewModel.phoneNumber, placeholder: "Phone number (optional)")
                
            }
            
            Spacer()
            
            Button("Continue") {
                Task {
                    await viewModel.createUserAndSaveProfile()
                }
            }
            .buttonStyle(.primary)
            .disabled(viewModel.isContinueButtonDisabled)
            
        }
        .padding()
        .background(Color.white.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar { CustomBackButtonToolbar() }
        // 3. This should navigate to TransitionView when profileSaveSuccess is true
        .navigationDestination(
            isPresented: $viewModel.profileSaveSuccess,
            destination: {
                TransitionView()
                    .environmentObject(sessionManager)
            }
        )
    }
}

#Preview {
    NavigationStack {
        CreateProfileView()
            .environmentObject(SessionManager())
    }
}
