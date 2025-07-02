import SwiftUI

struct CheckboxView: View {
    // A binding to a boolean that this checkbox will control
    @Binding var isChecked: Bool
    let label: AnyView
    
    // Initializer for simple text labels
    init(isChecked: Binding<Bool>, label: String) {
        self._isChecked = isChecked
        self.label = AnyView(Text(label))
    }
    
    // Initializer that can accept complex labels, like text with links
    init(isChecked: Binding<Bool>, @ViewBuilder label: () -> AnyView) {
        self._isChecked = isChecked
        self.label = label()
    }
    
    var body: some View {
        Button(action: {
            // Toggle the isChecked boolean when tapped
            withAnimation {
                isChecked.toggle()
            }
        }) {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundColor(isChecked ? .green : .gray)
                
                label
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
        }
    }
}