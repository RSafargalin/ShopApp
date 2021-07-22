//
//  Product.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 29.06.2021.
//

import Foundation

struct Product: Codable {
    let id: Int
    let name: String
    let price: Int
    let description: String
    
    public func getPriceInStringFormat() -> String {
        "\(price) ₽"
    }
}
