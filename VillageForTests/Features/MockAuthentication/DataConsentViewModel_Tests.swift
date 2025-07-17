////
////  DataConsentViewModel_Tests.swift
////  VillageForTests
////
////  Created by Srinadh Tanugonda on 7/8/25.
////
//import XCTest
//@testable import VillageFor // Makes your app's code available to the test target
//
//@MainActor
//final class DataConsentViewModel_Tests: XCTestCase {
//
//    // A variable to hold the ViewModel instance for each test
//    var viewModel: DataConsentViewModel!
//
//    // This function is called before each test runs.
//    // It's the perfect place to create a fresh instance of the ViewModel.
//    override func setUp() {
//        super.setUp()
//        viewModel = DataConsentViewModel()
//    }
//
//    // This function is called after each test runs.
//    // It's good practice to nil out your objects here to ensure a clean state.
//    override func tearDown() {
//        viewModel = nil
//        super.tearDown()
//    }
//
//    // MARK: - Test Cases
//
//    // Test naming convention: test_UnitOfWork_StateUnderTest_ExpectedBehavior
//
//    func test_DataConsentViewModel_isContinueButtonDisabled_isTrue_whenBothBoxesAreUnchecked() {
//        // Given: Both consent properties are false by default
//        
//        // Then: The button should be disabled
//        XCTAssertTrue(viewModel.isContinueButtonDisabled)
//    }
//    
//    func test_DataConsentViewModel_isContinueButtonDisabled_isTrue_whenOnlyOneBoxIsChecked() {
//        // Given: The user has only checked one of the two boxes
//        viewModel.agreesToHealthData = true
//        viewModel.agreesToTerms = false
//        
//        // Then: The button should still be disabled
//        XCTAssertTrue(viewModel.isContinueButtonDisabled)
//    }
//    
//    func test_DataConsentViewModel_isContinueButtonDisabled_isFalse_whenBothBoxesAreChecked() {
//        // Given: The user has checked both consent boxes
//        viewModel.agreesToHealthData = true
//        viewModel.agreesToTerms = true
//        
//        // Then: The button should be enabled
//        XCTAssertFalse(viewModel.isContinueButtonDisabled)
//    }
//    
//    func test_DataConsentViewModel_completeRegistration_setsConsentCompleteToTrue() {
//        // Given: The consentComplete flag is initially false
//        XCTAssertFalse(viewModel.consentComplete)
//        
//        // When: The completeRegistration function is called
//        viewModel.completeRegistration()
//        
//        // Then: The consentComplete flag should be set to true to trigger navigation
//        XCTAssertTrue(viewModel.consentComplete)
//    }
//}
