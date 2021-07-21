//
//  URL.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 21.07.2021.
//

import Foundation
import Alamofire

extension URL {
    
    static func getBaseURL() -> URL {
        let unSafeURL = URL(string: "https://vast-dusk-53457.herokuapp.com/")
        guard let safeURL = unSafeURL else {
            fatalError(AFError.invalidURL(url: unSafeURL?.absoluteString ?? "Undefined URL").localizedDescription)
        }
        return safeURL
    }

}
