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
        
        safePersonalArea.login(userName: TestConstant.User.username, password: TestConstant.User.password) { response in
            switch response.result {
            case .success(let login):
                XCTAssertEqual(login.user.id, TestConstant.User.userId)
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
        
        
        safePersonalArea.logout(userId: TestConstant.User.userId) {  response in
            switch response.result {
            case .success(let logout):
                XCTAssertEqual(logout.result, TestConstant.Server.Response.goodResultCode)
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
        
        let userData = UserData(userId: TestConstant.User.userId,
                                username: TestConstant.User.username,
                                password: TestConstant.User.password,
                                email: TestConstant.User.email,
                                gender: TestConstant.User.gender,
                                creditCard: TestConstant.User.creditCard,
                                bio: TestConstant.User.bio)
        
        safePersonalArea.checkIn(userData: userData) { response in
            switch response.result {
            case .success(let checkIn):
                XCTAssertEqual(checkIn.result, TestConstant.Server.Response.goodResultCode)
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
        
        let userData = UserData(userId: TestConstant.User.userId,
                                username: TestConstant.User.username,
                                password: TestConstant.User.password,
                                email: TestConstant.User.email,
                                gender: TestConstant.User.gender,
                                creditCard: TestConstant.User.creditCard,
                                bio: TestConstant.User.bio)
        
        safePersonalArea.changeData(userData: userData) { response in
            switch response.result {
            case .success(let changeData):
                XCTAssertEqual(changeData.result, TestConstant.Server.Response.goodResultCode)
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

//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
