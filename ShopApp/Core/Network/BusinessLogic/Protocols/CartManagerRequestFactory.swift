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
    
    func add(productId: ProductId,
             with quantity: Quantity,
             completion: @escaping (AFDataResponse<Response<ProductAddedToCard>>) -> Void)
    
    func remove(productId: ProductId,
                completion: @escaping (AFDataResponse<Response<ProductRemoveFromCart>>) -> Void)
    
    func pay(completion: @escaping (AFDataResponse<Response<PaingCart>>) -> Void)
    
}
