//
//  Review.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 05.07.2021.
//

import Foundation

struct Review: Codable {
    var id: Int
    var user: String
    var productId: Int
    var message: String
}
