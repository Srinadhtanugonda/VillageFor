//
//  MainTabView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/17/25.
//

import SwiftUI

struct MainTabView: View {
    // we will have user object here so that we can pass the user details if if we want them in specific tabs.
    
     let user: User
    
    // Access the sessionManager from the environment to pass it down or use it here.
    @EnvironmentObject var sessionManager: SessionManager
    
    @State private var selectedTab: TabBarModel = .home

    var body: some View {
        ZStack(alignment: .bottom) {
            // Main Content Area
            // The switch statement determines which view to show based on the selected tab.
            Group {
                switch selectedTab {
                case .home:
                    HomeView(user: user)
                case .tools:
                    //Passing below views temporarily. change it after creating in future development.
                    HomeView(user: user)
                case .learn:
                    HomeView(user: user)
                case .insights:
                    HomeView(user: user)
                case .me:
                    HomeView(user: user)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            TabBarView(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
    }
}
