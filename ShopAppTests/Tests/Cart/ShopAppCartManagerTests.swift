//
//  ShopAppCartManagerTests.swift
//  ShopAppTests
//
//  Created by Ruslan Safargalin on 11.07.2021.
//

import XCTest
@testable import ShopApp

class ShopAppCartManagerTests: XCTestCase {
    
    var requestFactory: RequestFactory?
    var cartManager: CartManager?
    
    override func setUpWithError() throws {
        requestFactory = RequestFactory()
        cartManager = requestFactory?.fetchRequestFactory()
        
    }

    override func tearDownWithError() throws {
        cartManager = nil
        requestFactory = nil
    }
    
    func testAddProductToCart() throws {
        let safeCatalog = try fetchSafeRequestFactory()
        let expectation = expectation(description: #function)
        
        safeCatalog.add(productId: 1, with: 1) { response in
            switch response.result {
            case .success(let result):
                XCTAssertNotNil(result.response.result, "Product result is nil")
                XCTAssertEqual(result.response.result, TestConstant.Server.Response.goodResultCode)
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: TestConstant.Server.WaitTime.ten.rawValue)
    }
    
    func testRemoveProductToCart() throws {
        let safeCatalog = try fetchSafeRequestFactory()
        let expectation = expectation(description: #function)
        
        safeCatalog.remove(productId: 1) { response in
            switch response.result {
            case .success(let result):
                XCTAssertNotNil(result.response.result, "Product result is nil")
                XCTAssertEqual(result.response.result, TestConstant.Server.Response.goodResultCode)
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: TestConstant.Server.WaitTime.ten.rawValue)
    }
    
    func testPayCart() throws {
        let safeCatalog = try fetchSafeRequestFactory()
        let expectation = expectation(description: #function)
        
        safeCatalog.pay() { response in
            switch response.result {
            case .success(let result):
                XCTAssertNotNil(result.response.result, "Product result is nil")
                XCTAssertEqual(result.response.result, TestConstant.Server.Response.goodResultCode)
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: TestConstant.Server.WaitTime.ten.rawValue)
    }
    
    private func fetchSafeRequestFactory() throws -> CartManagerRequestFactory {
        XCTAssertNotNil(cartManager, "Request factory is nil")
        do {
            let safeCartManager = try XCTUnwrap(cartManager, "Request factory is not unwrap")
            return safeCartManager
        } catch {
            throw error
        }
    }

}
