//
//  OnlyBasicUrl.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 29.06.2021.
//

import Foundation
import Alamofire

class OnlyBasicUrl: RequestRouter {
    let baseUrl: URL
    let method: HTTPMethod
    let path: String
    var parameters: Parameters?
    
    required init(baseUrl: URL, method: HTTPMethod = .get, path: String, parameters: Parameters? = nil) {
        self.baseUrl = baseUrl
        self.method = method
        self.path = path
        self.parameters = parameters
    }
}
