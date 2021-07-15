//
//  User.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 22.06.2021.
//

import Foundation

protocol UserDataProtocol: Codable {
    
    /// Логин пользователя
    var username: String { get }
    /// Пароль
    var password: String { get }
    /// Имя пользователя
    var firstName: String { get }
    /// Фамилия пользователя
    var surname: String { get }
    /// Email
    var email: String { get }
    /// Пол пользователя
    var gender: Bool { get }
    /// Номер кредитной карты пользователя
    var creditCard: String { get }
    /// Корзина пользователя
    var cart: [Int : Int] { get }
    
}

protocol UserProtocol: UserDataProtocol {
    
    /// ID пользователя
    var id: Int { get }
    
}

struct UserData: UserDataProtocol {
    
    let username: String,
        password: String,
        firstName: String,
        surname: String,
        email: String,
        gender: Bool,
        creditCard: String,
        cart: [Int : Int]
    
}

struct User: UserProtocol {
    
    let id: Int,
        username: String,
        password: String,
        firstName: String,
        surname: String,
        email: String,
        gender: Bool,
        creditCard: String,
        cart: [Int : Int]
    
}
