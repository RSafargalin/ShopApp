//
//  CheckInResult.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 25.06.2021.
//

import Foundation

struct CheckInResult: DefaultResult, Codable {
    let result: Int
    let userMessage: String
}

