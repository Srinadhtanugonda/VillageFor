//
//  LoginView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 6/30/25.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        // You would build your full Login UI here with fields for email/password
        // and a LoginViewModel to handle the logic.
        VStack {
            Text("Login View")
                .font(.largeTitle)
            Spacer()
        }
        .padding()
        .navigationTitle("Log In")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        LoginView()
    }
}
