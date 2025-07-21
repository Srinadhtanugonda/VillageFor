//
//  MoodCheckinView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/8/25.
//


import SwiftUI

struct MoodCheckinView: View {
    
    @StateObject private var viewModel: MoodCheckinViewModel
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var sessionManager: SessionManager
    
    init(dailyCheckin: DailyCheckin) {
        _viewModel = StateObject(wrappedValue: MoodCheckinViewModel(dailyCheckin: dailyCheckin))
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text("How do you feel today?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)
                .alignmentGuide(.leading) { $0[VerticalAlignment.top] }
            
            Spacer()
            
            CustomVerticalSlider(
                value: $viewModel.moodValue,
                range: 0...100,
                topLabel: "Positive",
                bottomLabel: "Negative",
                height: 400,
                width: 20
            )
            .frame(maxHeight: 400)
            
            
            Spacer()
            Spacer()
            
            Button("Continue") {
                Task {
                    viewModel.continueTapped()
                }
            }
            .buttonStyle(.primary)
        }
        .padding()
        .background(Color(UIColor.systemGray6).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar {
            CustomBackButtonToolbar()
        }
        .onAppear {
            // When this view appears, telling the session manager to hide the tab bar.
            sessionManager.isTabBarHidden = true
        }
        .navigationDestination(
            isPresented: $viewModel.shouldNavigateToEnergyCheck,
            destination: {
                let checkin = DailyCheckin(moodValue: viewModel.moodValue, timestamp: .init(date: Date()))
                EnergyLevelView(dailyCheckin: checkin) }
        )
    }
}

