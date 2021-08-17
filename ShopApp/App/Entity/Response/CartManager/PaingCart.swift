//
//  PaymentCart.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 10.07.2021.
//

import Foundation

struct PaingCart: Codable {
    var result: Int
    var paidGoods: [PaidGoods]
    var totalCost: Int
}
