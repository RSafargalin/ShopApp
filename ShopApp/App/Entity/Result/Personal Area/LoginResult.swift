//
//  LoginResult.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 22.06.2021.
//

import Foundation

struct LoginResult: DefaultResult, Codable {
    let result: Int
    let user: User
}
