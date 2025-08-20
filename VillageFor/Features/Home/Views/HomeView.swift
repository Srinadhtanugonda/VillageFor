//
//  HomeView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/2/25.
//


import SwiftUI


struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    @EnvironmentObject var sessionManager: SessionManager
    
    init(user: User) {
        // we are creating the ViewModel and injecting the user data.
        _viewModel = StateObject(wrappedValue: HomeViewModel(user: user))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    HeaderView(userName: viewModel.userName, signOutAction:{ viewModel.signOut() })
                    
                    // Daily Affirmation Card
                    AffirmationCard(affirmation: viewModel.dailyAffirmation)
                    
                    // Action Cards
                    HStack(spacing: 16) {
                        ActionCard(
                            title: "YOUR MOOD",
                            subtitle: "Check in",
                            action: { viewModel.navigateToMoodCheck() }
                        )
                        ActionCard(
                            title: "EPDS ASSESSMENT",
                            subtitle: "Take quiz",
                            action: { viewModel.navigateToEPDSAssessment() }
                        )
                    }
                    
                    // Support Section
                    SupportSection(articles: viewModel.supportArticles)
                }
                //pull-to-refresh functionality to check latest checkin.
                .refreshable {
                    await viewModel.fetchLatestCheckin()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40) // Extra padding for tab bar
            }
            .padding(.top, 15)
            .background(Color("LightGrayBG"))
            .ignoresSafeArea(.container, edges: .bottom) // Only ignore safe area at bottom
            .toolbar(.hidden, for: .navigationBar)
            .onAppear {
                sessionManager.isTabBarHidden = false
            }
            .navigationDestination(
                isPresented: $viewModel.shouldNavigateToMoodCheck,
                destination: {
                    // Creating a NEW DailyCheckin object when starting the flow.
                    let newCheckin = DailyCheckin(timestamp: .init(date: Date()))
                    MoodCheckinView(dailyCheckin: newCheckin)
                }
            )
//            .navigationDestination(
//                isPresented: $viewModel.shouldNavigateToEPDSAssessment,
//                destination: {
//                    var checkin = viewModel.latestCheckin
//                    EnergyLevelView(dailyCheckin: checkin) }
//            )
        }
    }
}

#Preview {
    let sampleUser = User(id: "123", email: "preview@test.com", firstName: "Caroline", lastName: "Brown")

    NavigationStack {
        HomeView(user: sampleUser).environmentObject(SessionManager())
    }
}



