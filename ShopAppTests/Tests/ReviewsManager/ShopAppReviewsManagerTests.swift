//
//  ShopAppReviewsManagerTests.swift
//  ShopAppTests
//
//  Created by Ruslan Safargalin on 05.07.2021.
//

import XCTest
@testable import ShopApp

class ShopAppReviewsManagerTests: XCTestCase {
    
    var requestFactory: RequestFactory?
    var reviewsManager: ReviewManager?
    
    override func setUpWithError() throws {
        requestFactory = RequestFactory()
        reviewsManager = requestFactory?.fetchRequestFactory()
    }

    override func tearDownWithError() throws {
        reviewsManager = nil
        requestFactory = nil
    }
    
    func testFetchReviewsForProduct() throws {
        let safeFactory = try fetchSafeReviewsManagerRequestFactory()
        let expectation = expectation(description: #function)
        
        safeFactory.fetchAllReviews(for: 1) { response in
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
    
    func testAddReviewForProduct() throws {
        let safeFactory = try fetchSafeReviewsManagerRequestFactory()
        let expectation = expectation(description: #function)
        
        safeFactory.addReview(for: 1, with: "user", and: "Good product") { response in
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
    
    func testRemoveReviewForProduct() throws {
        let safeFactory = try fetchSafeReviewsManagerRequestFactory()
        let expectation = expectation(description: #function)
        sleep(2)
        safeFactory.removeReview(with: 1, for: 1) { response in
            switch response.result {
            case .success(let result):
                XCTAssertNotNil(result.response.result, "Product result is nil")
                XCTAssertEqual(result.response.result, TestConstant.Server.Response.goodResultCode)
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 20)
    }
    
    
    
    private func fetchSafeReviewsManagerRequestFactory() throws -> ReviewManagerRequestFactory {
        XCTAssertNotNil(reviewsManager, "Request factory is nil")
        do {
            let safeReviewsManager = try XCTUnwrap(reviewsManager, "Request factory is not unwrap")
            return safeReviewsManager
        } catch {
            throw error
        }
    }

}
