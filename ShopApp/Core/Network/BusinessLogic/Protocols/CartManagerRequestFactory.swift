//
//  CartManagerRequestFactory.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 10.07.2021.
//

import Foundation
import Alamofire

protocol CartManagerRequestFactory {
    
    typealias Quantity = Int
    typealias ProductId = Int
    typealias UserId = Int
    
    func add(productId: Int, with quantity: Int, completion: @escaping (AFDataResponse<Response<ProductAddedToCard>>) -> Void)
    func remove(productId: Int, completion: @escaping (AFDataResponse<Response<ProductRemoveFromCart>>) -> Void)
    func pay(completion: @escaping (AFDataResponse<Response<PaingCart>>) -> Void)
    
}
