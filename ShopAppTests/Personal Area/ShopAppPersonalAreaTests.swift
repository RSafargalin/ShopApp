//
//  ShopAppPersonalAreaTests.swift
//  ShopAppPersonalAreaTests
//
//  Created by Ruslan Safargalin on 19.06.2021.
//

import XCTest
@testable import ShopApp

class ShopAppPersonalAreaTests: XCTestCase {
    
    var requestFactory: RequestFactory?
    var personalArea: PersonalArea?

    override func setUpWithError() throws {
        requestFactory = RequestFactory()
        personalArea = requestFactory?.fetchRequestFactory()
    }

    override func tearDownWithError() throws {
        personalArea = nil
        requestFactory = nil
    }
    
    func testLogin() throws {
        let safePersonalArea = try fetchSafePersonalAreaRequestFactory()
        let expectation = expectation(description: #function)
        
        safePersonalArea.login(userName: TestConstant.User.StringValues.username.rawValue, password: TestConstant.User.StringValues.password.rawValue) { response in
            switch response.result {
            case .success(let login):
                XCTAssertEqual(login.response.user.id, TestConstant.User.IntValues.id.rawValue)
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: TestConstant.Server.WaitTime.ten.rawValue)
    }
    
    func testLogout() throws {
        let safePersonalArea = try fetchSafePersonalAreaRequestFactory()
        let expectation = expectation(description: #function)
        
        
        safePersonalArea.logout(userId: TestConstant.User.IntValues.id.rawValue) {  response in
            switch response.result {
            case .success(let logout):
                XCTAssertEqual(logout.response.result, TestConstant.Server.Response.goodResultCode)
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: TestConstant.Server.WaitTime.ten.rawValue)
    }
    
    func testCheckIn() throws {
        let safePersonalArea = try fetchSafePersonalAreaRequestFactory()
        let expectation = expectation(description: #function)
        
        let userData = UserData(name: TestConstant.User.StringValues.username.rawValue,
                                password: TestConstant.User.StringValues.password.rawValue,
                                email: TestConstant.User.StringValues.email.rawValue,
                                gender: false,
                                creditCard: TestConstant.User.StringValues.creditCard.rawValue,
                                bio: TestConstant.User.StringValues.bio.rawValue)
        
        safePersonalArea.checkIn(userData) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.response.result, TestConstant.Server.Response.goodResultCode)
                expectation.fulfill()
                
            case .failure(let error):
                print(error)
            }
        }
        
        waitForExpectations(timeout: TestConstant.Server.WaitTime.ten.rawValue)
    }
    
    func testChangeData() throws {
        let safePersonalArea = try fetchSafePersonalAreaRequestFactory()
        let expectation = expectation(description: #function)
        
        let userData = User(id: TestConstant.User.IntValues.id.rawValue,
                            name: TestConstant.User.StringValues.username.rawValue,
                            password: TestConstant.User.StringValues.password.rawValue,
                            email: TestConstant.User.StringValues.email.rawValue,
                            gender: false,
                            creditCard: TestConstant.User.StringValues.creditCard.rawValue,
                            bio: TestConstant.User.StringValues.bio.rawValue)
        
        safePersonalArea.changeData(userData) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.response.result, TestConstant.Server.Response.goodResultCode)
                expectation.fulfill()
                
            case .failure(let error):
                print(error)
            }
        }
        
        waitForExpectations(timeout: TestConstant.Server.WaitTime.ten.rawValue)
    }
    
    private func fetchSafePersonalAreaRequestFactory() throws -> PersonalAreaRequestFactory {
        XCTAssertNotNil(personalArea, "Request factory is nil")
        do {
            let safePersonalArea = try XCTUnwrap(personalArea, "Request factory is not unwrap")
            return safePersonalArea
        } catch {
            throw error
        }
    }
}
