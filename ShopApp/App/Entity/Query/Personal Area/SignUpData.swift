//
//  SignUpData.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 03.07.2021.
//

import Foundation

struct SignUpData: Codable {
    let username: String,
        password: String,
        email: String,
        gender: Bool,
        creditCard: String,
        bio: String
}
