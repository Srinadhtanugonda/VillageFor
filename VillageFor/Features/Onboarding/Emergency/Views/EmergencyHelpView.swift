//
//  EmergencyHelpView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/28/25.
//


//
//  EmergencyHelpView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/28/25.
//

import SwiftUI

struct EmergencyHelpView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var sessionManager: SessionManager
    
    private let backgroundColor = Color("ThemeGreen")
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                
                // Title
                Text("Let's find help")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                
                // First help option
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "arrow.right")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                            .padding(.top, 2)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Call or text the National Maternal Mental Health Hotline")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                            Text("This confidential, toll-free, government hotline is available in English and Spanish at 1-833-TLC-MAMA (1-833-852-6262).")
                                .font(.body)
                                .foregroundColor(.white)
                                .opacity(0.9)
                        }
                    }
                }
                .padding(.bottom, 32)
                
                // Second help option
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "arrow.right")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .medium))
                            .padding(.top, 2)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Reach out to your village")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                            Text("We'll generate a pre-written text message for you to send.")
                                .font(.body)
                                .foregroundColor(.white)
                                .opacity(0.9)
                        }
                    }
                }
                
                Spacer()
                
                
                Image("you_are_not_alone")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 60)
                    .opacity(0.4)
                    .padding(.bottom, 40)
                
                // Action buttons
                VStack(spacing: 16) {
                    Button("Text your village") {
                        if let url = URL(string: "sms:15083040315") {
                            UIApplication.shared.open(url)
                        }
                    }
                    .buttonStyle(.secondary)
                    
                    
                    Button("Text the hotline") {
                        if let url = URL(string: "sms:18338526262") {
                            UIApplication.shared.open(url)
                        }
                    }
                    .buttonStyle(.secondary)
                    
                    Button("Call the hotline") {
                        if let url = URL(string: "tel:18338526262") {
                            UIApplication.shared.open(url)
                        }
                    }
                    .buttonStyle(.secondary)
                    
                }
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 24)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            CustomBackButtonToolbar(foregroundColor: .white)
        }
        
    }
}

#Preview {
    NavigationStack {
        EmergencyHelpView().environmentObject(SessionManager())
    }
}
