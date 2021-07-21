//
//  ReviewManager.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 05.07.2021.
//

import Foundation
import Alamofire

class ReviewManager: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = Constant.ReviewManager.baseUrl
    
    required init(errorParser: AbstractErrorParser,
                  sessionManager: Session,
                  queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
        
    }
}

extension ReviewManager: ReviewManagerRequestFactory {
    
    typealias ReviewId = Int
    typealias ProductId = Int
    typealias UserId = Int
    typealias Message = String
    
    func fetchAllReviews(for productId: ProductId,
                         completion: @escaping (AFDataResponse<Response<ReviewsForProduct>>) -> Void) {
        
        let requestModel = AllReviewsForProduct(baseUrl: baseUrl, id: productId)
        self.request(request: requestModel, completionHandler: completion)
        
    }
    
    func removeReview(with reviewId: ReviewId,
                      for productId: ProductId,
                      completion: @escaping (AFDataResponse<Response<ReviewRemove>>) -> Void) {
        
        let requestModel = RemoveReviewForProduct(baseUrl: baseUrl, productId: productId, reviewId: reviewId)
        self.request(request: requestModel, completionHandler: completion)
        
    }
    
    func addReview(for productId: ProductId,
                   with userId: UserId,
                   and message: Message,
                   completion: @escaping (AFDataResponse<Response<ReviewAdded>>) -> Void) {
        
        let requestModel = AddReviewForProduct(baseUrl: baseUrl, productId: productId, userId: userId, message: message)
        self.request(request: requestModel, completionHandler: completion)
        
    }

}

extension ReviewManager {
    
    struct AllReviewsForProduct: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = Constant.ReviewManager.All.path.rawValue
        
        let id: Int
        var parameters: Parameters? {
            return [
                Constant.ReviewManager.Parameters.id.rawValue: id,
            ]
        }
    }
    
    struct RemoveReviewForProduct: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = Constant.ReviewManager.Remove.path.rawValue
        
        let productId: Int
        let reviewId: Int
        var parameters: Parameters? {
            return [
                Constant.ReviewManager.Parameters.productId.rawValue: productId,
                Constant.ReviewManager.Parameters.reviewId.rawValue: reviewId
            ]
        }
    }
    
    struct AddReviewForProduct: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = Constant.ReviewManager.Add.path.rawValue
        
        let productId: Int
        let userId: Int
        let message: String
        var parameters: Parameters? {
            return [
                Constant.ReviewManager.Parameters.productId.rawValue: productId,
                Constant.ReviewManager.Parameters.userId.rawValue: userId,
                Constant.ReviewManager.Parameters.message.rawValue: message
            ]
        }
    }
    
}
