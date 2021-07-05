//
//  ChangeQueryData.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 25.06.2021.
//

import Foundation

struct ChangeQueryData: Codable {
    let id: Int,
        username: String,
        password: String,
        email: String,
        gender: Bool,
        creditCard: String,
        bio: String
}

