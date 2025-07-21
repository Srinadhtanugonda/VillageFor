//
//  DebugLaunch_UITests.swift
//  VillageFor
//
//  Created by Srinadh Tanugonda on 7/18/25.
//


import XCTest

// This test case is designed specifically to launch the app into a debug state.
final class DebugLaunch_UITests: XCTestCase {

    // This test will launch the app and then immediately finish,
    // leaving the app open on the simulator for you to work with.
    func test_launchAppAndBypassLoginForUIDevelopment() throws {
        // Create a reference to the application.
        let app = XCUIApplication()
        
        // Add our special command to the launch arguments.
        app.launchArguments = ["-debugBypassLogin"]
        
        // Launch the app.
        app.launch()

        // We can add an assertion here to make sure it worked.
        let welcomeMessage = app.staticTexts["WelcomeUserNameTextFieldInHeader"]
               XCTAssertTrue(welcomeMessage.waitForExistence(timeout: 5))
        // The test will now end, but the app will remain open on your simulator
        // in the correct state for you to begin your UI work.
    }
}
