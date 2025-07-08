//
//  SupportSection.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/2/25.
//

import SwiftUI

struct SupportSection: View {
    let articles: [Article]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("How can we support you today?")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            LazyVStack(spacing: 12) {
                ForEach(articles) { article in
                    ArticleCard(article: article)
                }
            }
        }
    }
}
