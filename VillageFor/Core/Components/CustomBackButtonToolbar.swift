//
//  CustomBackButtonToolbar.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//


import SwiftUI

// reusae this toolbar component to display a custom back button of your custom color.
struct CustomBackButtonToolbar: ToolbarContent {
    
    // We need to get the dismiss action from the view that uses this component.
    @Environment(\.dismiss) private var dismiss
    private let foregroundColor: Color
    
    init(foregroundColor: Color = .black) {
        self.foregroundColor = foregroundColor
    }
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(foregroundColor)
                    .font(.system(size: 18, weight: .medium))
            }
        }
    }
}

