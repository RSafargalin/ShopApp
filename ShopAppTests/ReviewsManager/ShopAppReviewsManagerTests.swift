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
        let productId = 1
        let saveReviewsManager = try fetchSafeReviewsManagerRequestFactory()
        saveReviewsManager.fetchAllReviews(for: productId) { response in
            switch response.result {
            case .success(let result):
                print(result.response.reviews)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func testRemoveReviewForProduct() throws {
        let productId = 1
        let reviewId = 12
        let saveReviewsManager = try fetchSafeReviewsManagerRequestFactory()
        saveReviewsManager.removeReview(with: reviewId, for: productId) { response in
            switch response.result {
            case .success(let result):
                print(result.response)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func testAddReviewForProduct() throws {
        let productId = 1
        let userId = 1
        let message = "Good product"
        let saveReviewsManager = try fetchSafeReviewsManagerRequestFactory()
        saveReviewsManager.addReview(for: productId, with: userId, and: message) { response in
            switch response.result {
            case .success(let result):
                print(result.response)
                
            case .failure(let error):
                print(error)
            }
        }
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
