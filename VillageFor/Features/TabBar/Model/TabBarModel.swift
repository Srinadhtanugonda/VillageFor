//
//  TabBarModel.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/17/25.
//

import Foundation

enum TabBarModel: String, CaseIterable {
    case home = "Home"
    case tools = "Tools"
    case learn = "Learn"
    case insights = "Insights"
    case me = "Me"
    
    var icon: String {
           switch self {
           case .home:
               return "house"
           case .tools:
               return "sparkles"
           case .learn:
               return "lightbulb"
           case .insights:
               return "chart.line.uptrend.xyaxis"
           case .me:
               return "person"
           }
       }
    
    var selectedIcon: String {
            switch self {
            case .home:
                return "house.fill"
            case .tools:
                return "sparkles.fill"
            case .learn:
                return "lightbulb.fill"
            case .insights:
                return "chart.line.uptrend.xyaxis"
            case .me:
                return "person.fill"
            }
        }

}
