//
//  PaidGoods.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 10.07.2021.
//

import Foundation

struct PaidGoods: Codable {
    var productId: Int,
        productName: String,
        quantity: Int,
        totalCost: Int
}
