//
//  TabBarView.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/17/25.
//

import SwiftUI

struct TabBarView: View {
    
    @Binding var selectedTab : TabBarModel
    
    var body: some View {
        HStack {
            ForEach(TabBarModel.allCases, id: \.self) { tab in
                Spacer()

                TabBarItem(
                    tab: tab,
                    isSelected: selectedTab == tab,
                    action: {
                        withAnimation(.spring()) {
                            selectedTab = tab
                        }
                    }
                )
                Spacer()
            }
        }
        .frame(height: 72)
        .background(.ultraThinMaterial)
        .cornerRadius(35)
        .padding(.horizontal)
    }
}

private struct TabBarItem: View {
    let tab: TabBarModel
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: isSelected ? tab.selectedIcon : tab.icon)
                    .font(.title2)
                
                Text(tab.rawValue)
                    .font(.caption)
            }
            .foregroundColor(isSelected ? Color("ThemeGreen") : .gray)
        }
    }
}
