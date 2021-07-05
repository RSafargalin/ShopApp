//
//  ReviewManagerRequestFactory.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 05.07.2021.
//

import Foundation
import Alamofire

protocol ReviewManagerRequestFactory {
    
    typealias ReviewId = Int
    typealias ProductId = Int
    typealias UserId = Int
    typealias Message = String
    
    func fetchAllReviews(for productId: ProductId, completion: @escaping (AFDataResponse<Response<ReviewsForProduct>>) -> Void)
    func removeReview(with reviewId: ReviewId, for productId: ProductId, completion: @escaping (AFDataResponse<Response<ReviewRemove>>) -> Void)
    func addReview(for productId: ProductId, with userId: UserId, and message: Message, completion: @escaping (AFDataResponse<Response<ReviewAdded>>) -> Void)
    
}
