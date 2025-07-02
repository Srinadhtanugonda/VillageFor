import SwiftUI

struct CreateProfileView: View {
    
    @StateObject private var viewModel = CreateProfileViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Welcome to VillageFor")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            TextField("First name", text: $viewModel.firstName)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3), lineWidth: 1))
            
            TextField("Last name", text: $viewModel.lastName)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3), lineWidth: 1))
            
            TextField("Email address", text: $viewModel.email)
                .padding()
                .background(Color(white: 0.95)) // Make it look disabled
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.2), lineWidth: 1))
                .disabled(true) // Pre-populated, so disable it
            
            TextField("Phone number (optional)", text: $viewModel.phoneNumber)
                .keyboardType(.phonePad)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3), lineWidth: 1))
            
            Spacer()
            
            Button(action: {
                Task {
                    await viewModel.saveProfile()
                }
            }) {
                Text("Continue")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isContinueButtonDisabled ? Color.gray.opacity(0.5) : Color(red: 0.2, green: 0.4, blue: 0.3))
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            .disabled(viewModel.isContinueButtonDisabled)
        }
        .padding()
        .background(Color(red: 0.97, green: 0.97, blue: 0.96).ignoresSafeArea())
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
        CreateProfileView()
    }
}