//
//  ChangeQueryData.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 25.06.2021.
//

import Foundation

struct ChangeQueryData: Codable {
    var id: Int,
        username: String?,
        password: String?,
        firstName: String?,
        surname: String?,
        email: String?,
        gender: Bool?,
        creditCard: String?
}

