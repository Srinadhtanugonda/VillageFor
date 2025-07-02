import SwiftUI

struct EmergencyDisclaimerView: View {
    
    @StateObject private var viewModel = EmergencyDisclaimerViewModel()
    @Environment(\.dismiss) private var dismiss
    
    // Define the custom green color from your design
    private let backgroundColor = Color(red: 0.2, green: 0.4, blue: 0.3)
    
    var body: some View {
        ZStack {
            // Set the background color for the entire screen
            backgroundColor.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                
                // Header Content
                VStack(alignment: .leading, spacing: 8) {
                    Text("Is this an emergency?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("We want to help, but we're not an emergency service. Select yes if:")
                        .font(.subheadline)
                }
                .padding(.bottom, 20)
                
                // Bullet points
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "arrow.right")
                        Text("You are currently experiencing a mental health crisis")
                    }
                    HStack {
                        Image(systemName: "arrow.right")
                        Text("You are in need of immediate help")
                    }
                }
                .font(.headline)
                .fontWeight(.regular)
                
                Spacer()
                
                // Scrolling Text at the bottom (Decorative)
                // We'll use a simple Text view for this placeholder
                Text("not alone . you are not alone")
                    .font(.title)
                    .fontWeight(.light)
                    .opacity(0.3)
                    .padding(.bottom, 20)

                
                // Yes/No Buttons
                VStack(spacing: 12) {
                    Button(action: {
                        viewModel.yesButtonTapped()
                    }) {
                        Text("Yes")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(24)
                    }
                    
                    Button(action: {
                        viewModel.noButtonTapped()
                    }) {
                        Text("No")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(24)
                    }
                }
            }
            .foregroundColor(.white) // Make all text white against the green background
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    // Wrap in a NavigationView for previewing the toolbar
    NavigationView {
        EmergencyDisclaimerView()
    }
}