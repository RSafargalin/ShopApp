//
//  SignInType.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 22.06.2021.
//

import Foundation

struct SignInType: ResponseType, Codable {
    let result: Int
    let user: ChangeQueryData
    
}
