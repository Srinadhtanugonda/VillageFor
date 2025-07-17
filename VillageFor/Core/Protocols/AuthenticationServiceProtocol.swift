//
//  AuthenticationServiceProtocol.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/8/25.
//

import Foundation

// This protocol defines the "contract" for what an authentication service must be able to do.
protocol AuthenticationServiceProtocol {
    func signOut() throws
    // We would add other functions here as needed, like signUp, signIn, etc.
}
