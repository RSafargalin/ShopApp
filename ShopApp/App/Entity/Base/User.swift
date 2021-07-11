//
//  User.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 22.06.2021.
//

import Foundation

protocol UserDataProtocol: Codable {
    
    /// Имя пользователя
    var name: String { get }
    /// Пароль
    var password: String { get }
    /// Email
    var email: String { get }
    /// Пол пользователя
    var gender: Bool { get }
    /// Номер кредитной карты пользователя
    var creditCard: String { get }
    /// Биография пользователя
    var bio: String { get }
    /// Корзина пользователя
    var cart: [Int : Int] { get }
    
}

protocol UserProtocol: UserDataProtocol {
    
    /// ID пользователя
    var id: Int { get }
    
}

struct UserData: UserDataProtocol {
    
    let name: String,
        password: String,
        email: String,
        gender: Bool,
        creditCard: String,
        bio: String,
        cart: [Int : Int]
    
}

struct User: UserProtocol {
    
    let id: Int,
        name: String,
        password: String,
        email: String,
        gender: Bool,
        creditCard: String,
        bio: String,
        cart: [Int : Int]
    
}
