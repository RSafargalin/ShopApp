//
//  ShopAppUITests.swift
//  ShopAppUITests
//
//  Created by Ruslan Safargalin on 19.06.2021.
//

import XCTest
@testable import ShopApp

class ShopAppUITests: XCTestCase {

    // MARK: - Variables
    
    var app: XCUIApplication!
    var scrollViewsQuery: XCUIElementQuery!
    var scrollView: XCUIElementQuery!
    var username: String = ""
    var password: String = ""
    
    // MARK: - Settings Methods
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        scrollView = app.scrollViews.otherElements
        continueAfterFailure = false
        username = ""
        password = ""
    }

    override func tearDownWithError() throws { }

    // MARK: - Tests
    
    func testOnSuccessLogin() throws {
        algorithmUITestOnSignIn(for: .success)
    }
    
    func testFailedLogin() throws {
        algorithmUITestOnSignIn(for: .failed)
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    // MARK: - Enum
    
    enum TestType {
        case success,
             failed
    }
    
    // MARK: - Private Methods
    
    private func algorithmUITestOnSignIn(for test: TestType,
                                         sleep time: UInt32 = 5,
                                         expectation timeout: TimeInterval = 40) {
        
        switch test {
        case .success:
            self.username = "LewisHamilton"
            self.password = "stillirise"
            
        case .failed:
            self.username = "LewisHamilton"
            self.password = "badpassword"
        }
        
        let expectations = expectation(description: #function)
        let loginTextField = scrollView.textFields["Login..."]
        loginTextField.tap()
        loginTextField.typeText(self.username)
        
        let passwordSecureTextField = scrollView.secureTextFields["Password..."]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText(self.password)
        
        scrollView.buttons["Join"].tap()

        sleep(time)
        
        switch test {
        case .success:
            XCTAssertTrue(app.navigationBars["Lewis Hamilton"].exists)
            XCTAssertTrue(app.navigationBars["Lewis Hamilton"].staticTexts["Lewis Hamilton"].exists)
            
        case .failed:
            XCTAssertFalse(app.navigationBars["Lewis Hamilton"].exists)
            XCTAssertFalse(app.navigationBars["Lewis Hamilton"].staticTexts["Lewis Hamilton"].exists)
        }
    
        expectations.fulfill()
        waitForExpectations(timeout: timeout)
    }
    
}
