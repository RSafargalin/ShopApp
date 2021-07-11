//
//  CartManager.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 10.07.2021.
//

import Foundation
import Alamofire

class CartManager: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = Constant.ReviewManager.baseUrl
    
    required init(errorParser: AbstractErrorParser, sessionManager: Session, queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension CartManager: CartManagerRequestFactory {
    
    typealias ReviewId = Int
    typealias ProductId = Int
    typealias UserId = Int
    typealias Message = String
    
    func add(productId: Int, with quantity: Int, completion: @escaping (AFDataResponse<Response<ProductAddedToCard>>) -> Void) {
        let requestModel = AddProductToCart(baseUrl: baseUrl, productId: productId, quantity: quantity, userId: SessionData.shared.user.id)
        self.request(request: requestModel, completionHandler: completion)
    }
    
    func remove(productId: Int, completion: @escaping (AFDataResponse<Response<ProductRemoveFromCart>>) -> Void) {
        let requestModel = RemoveProductFromCart(baseUrl: baseUrl, productId: productId, userId: SessionData.shared.user.id)
        self.request(request: requestModel, completionHandler: completion)
    }
    
    func pay(completion: @escaping (AFDataResponse<Response<PaingCart>>) -> Void) {
        let requestModel = PayCart(baseUrl: baseUrl, userId: SessionData.shared.user.id)
        self.request(request: requestModel, completionHandler: completion)
    }

}

extension CartManager {
    
    struct AddProductToCart: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = Constant.CartManager.Add.path.rawValue
        
        let productId: Int
        let quantity: Int
        let userId: Int
        var parameters: Parameters? {
            return [
                Constant.CartManager.Parameters.productId.rawValue: productId,
                Constant.CartManager.Parameters.quantity.rawValue: quantity,
                Constant.CartManager.Parameters.userId.rawValue: userId
            ]
        }
    }
    
    struct RemoveProductFromCart: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = Constant.CartManager.Remove.path.rawValue
        
        let productId: Int
        let userId: Int
        var parameters: Parameters? {
            return [
                Constant.CartManager.Parameters.productId.rawValue: productId,
                Constant.CartManager.Parameters.userId.rawValue: userId
            ]
        }
    }
    
    struct PayCart: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = Constant.CartManager.Pay.path.rawValue
        
        let userId: Int
        var parameters: Parameters? {
            return [
                Constant.CartManager.Parameters.userId.rawValue: userId
            ]
        }
    }
    
}
