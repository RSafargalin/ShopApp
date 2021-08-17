//
//  ProductsOnCart.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 23.07.2021.
//

import Foundation

struct ProductsOnCart: Codable {
    var result: Int
    var products: [ProductOnCart]
}
