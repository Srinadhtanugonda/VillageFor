//
//  EnergyLevelView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/8/25.
//

import SwiftUI

struct EnergyLevelView: View {
    
    @StateObject private var viewModel: EnergyLevelViewModel
    @EnvironmentObject var sessionManager: SessionManager
    //    @Environment(\.dismiss) private var dismiss
    
    init(dailyCheckin: DailyCheckin) {
        _viewModel = StateObject(wrappedValue: EnergyLevelViewModel(dailyCheckin: dailyCheckin))
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text("How are your energy levels?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)
                .alignmentGuide(.leading) { $0[VerticalAlignment.top] }
            
            Spacer()
            
            CustomVerticalSlider(
                value: $viewModel.energyValue,
                range: 0...100,
                topLabel: "A lot of energy",
                bottomLabel: "No energy",
                height: 400,
                width: 20
            )
            .frame(maxHeight: 400)
            
            Spacer()
            Spacer()
            
            Button("Continue") {
                Task {
                    viewModel.contiueTapped()
                }
            }
            .buttonStyle(.primary)
            .padding(.horizontal, 24)
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
            isPresented: $viewModel.shouldNavigateToSelectAnEmotion
        ) {
            SelectEmotionView(dailyCheckin: updatedCheckin)
        }
    }
    private var updatedCheckin: DailyCheckin {
        var checkin = viewModel.dailyCheckin
        checkin.energyValue = viewModel.energyValue
        return checkin
    }
}

#Preview {
    // The preview needs a sample DailyCheckin object to work
    let sampleCheckin = DailyCheckin(timestamp: .init(date: Date()))
    
    return EnergyLevelView(dailyCheckin: sampleCheckin)
        .environmentObject(SessionManager())
}
