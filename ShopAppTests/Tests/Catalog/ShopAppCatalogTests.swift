//
//  ShopAppCatalogTests.swift
//  ShopAppTests
//
//  Created by Ruslan Safargalin on 29.06.2021.
//

import XCTest
@testable import ShopApp

class ShopAppCatalogTests: XCTestCase {

    var requestFactory: RequestFactory?
    var catalog: Catalog?
    
    override func setUpWithError() throws {
        requestFactory = RequestFactory()
        catalog = requestFactory?.fetchRequestFactory()
    }

    override func tearDownWithError() throws {
        catalog = nil
        requestFactory = nil
    }
    
    func testFetchAll() throws {
        let safeCatalog = try fetchSafeCatalogRequestFactory()
        let expectation = expectation(description: #function)
        
        safeCatalog.fetchAll { response in
            switch response.result {
            case .success(let result):
                XCTAssertNotEqual(result.response.products.count, 0, "Products is empty")
                XCTAssertNotNil(result.response.products.first, "Product first item is nil")
                XCTAssertEqual(result.response.products.first!.name, TestConstant.Product.name)
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: TestConstant.Server.WaitTime.ten.rawValue)
    }
    
    func testFetchProductForId() throws {
        let safeCatalog = try fetchSafeCatalogRequestFactory()
        let expectation = expectation(description: #function)
        
        safeCatalog.fetchProduct(for: TestConstant.Product.id) { response in
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
    
    private func fetchSafeCatalogRequestFactory() throws -> CatalogRequestFactory {
        XCTAssertNotNil(catalog, "Request factory is nil")
        do {
            let safeCatalog = try XCTUnwrap(catalog, "Request factory is not unwrap")
            return safeCatalog
        } catch {
            throw error
        }
    }
}
