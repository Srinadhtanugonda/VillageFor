//
//  Article.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/2/25.
//


import Foundation

struct Article: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let imageURL: String
}
