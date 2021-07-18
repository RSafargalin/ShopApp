//
//  CatalogRequestFactory.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 29.06.2021.
//

import Foundation
import Alamofire

protocol CatalogRequestFactory {
    
    func fetchAll(completionHandler: @escaping (AFDataResponse<Response<ProductsType>>) -> Void)
    func fetchProduct(for id: Int, completionHandler: @escaping (AFDataResponse<Response<ProductType>>) -> Void)
    
}
