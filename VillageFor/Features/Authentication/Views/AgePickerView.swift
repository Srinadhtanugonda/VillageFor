import SwiftUI

struct AgePickerView: View {
    @StateObject private var viewModel = AgePickerViewModel()
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var sessionManager: SessionManager

    
    var body: some View {
        VStack(spacing: 0) {
            Text("How old are you?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Spacer()
            
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 0) {
                        Color.clear.frame(height: 240)
                        
                        ForEach(viewModel.ageRange, id: \.self) { age in
                            GeometryReader { geo in
                                let distance = abs(geo.frame(in: .global).midY - UIScreen.main.bounds.height / 2)
                                let isSelected = distance < 40
                                let opacity = max(0.3, 1.2 - distance / 150)
                                let fontSize: CGFloat = isSelected ? 48 : max(24, 48 - distance / 11)
                                
                                Text("\(age)")
                                    .font(.system(size: fontSize, weight: .medium))
                                    .foregroundColor(Color("ThemeGreen"))
                                    .opacity(opacity)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color("ThemeGreen").opacity(0.1))
                                            .opacity(isSelected ? 1 : 0)
                                    )
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            proxy.scrollTo(age, anchor: .center)
                                        }
                                    }
                            }
                            .frame(height: 70)
                            .id(age)
                        }
                        
                        Color.clear.frame(height: 160)
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        proxy.scrollTo(34, anchor: .center)
                    }
                }
            }
            .frame(height: 480)
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
        .background(Color(UIColor.systemGray6))
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
