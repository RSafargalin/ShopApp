//
//  Catalog.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 29.06.2021.
//

import Foundation
import Alamofire

class Catalog: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = Constant.Catalog.baseUrl
    
    required init(errorParser: AbstractErrorParser, sessionManager: Session, queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Catalog: CatalogRequestFactory {
    func fetchAll(completionHandler: @escaping (AFDataResponse<[ProductResult]>) -> Void) {
        let requestModel = OnlyBasicUrl(baseUrl: baseUrl, path: Constant.Catalog.Products.path)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func fetchProduct(for id: Int, completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void) {
        let requestModel = FetchProductForId(baseUrl: baseUrl, productId: id)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Catalog {
    struct FetchProductForId: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = Constant.Catalog.Product.path
        
        let productId: Int
        var parameters: Parameters? {
            return [
                Constant.Catalog.Parameters.id: productId,
            ]
        }
    }
}
