//
//  Constant.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 25.06.2021.
//

import Foundation

struct Constant {
    
    // MARK: - Personal Area
    
    enum PersonalArea {
        static let baseUrl: URL = URL(string: "https://vast-dusk-53457.herokuapp.com/")!
        
        enum Parameters: String {
            case id = "id",
                 name = "name",
                 password = "password",
                 email = "email",
                 gender = "gender",
                 creditCard = "creditCard",
                 bio = "bio"
        }
        
        enum SignIn: String {
            case path = "signIn"
        }
        
        enum Logout: String {
            case path = "logout"
        }
        
        enum SignUp: String {
            case path = "signUp"
        }
        
        enum ChangeData: String {
            case path = "changeUserData"
        }
    }
    
    // MARK: - Catalog
    
    enum Catalog {
        static let baseUrl: URL = URL(string: "https://vast-dusk-53457.herokuapp.com/")!
        
        enum Products: String {
            case path = "products"
        }
        
        enum Product: String {
            case path = "product"
        }
        
        enum Parameters: String {
            case id = "id"
        }
    }
    
    // MARK: - ReviewManager
    
    enum ReviewManager {
        static let baseUrl: URL = URL(string: "https://vast-dusk-53457.herokuapp.com/")!
        
        enum Parameters: String {
            case id,
                 userId,
                 productId,
                 message,
                 reviewId
        }
        
        enum All: String {
            case path = "reviews.all"
        }
        
        enum Remove: String {
            case path = "reviews.remove"
        }
        
        enum Add: String {
            case path = "reviews.add"
        }
    }
    
    // MARK: - Cart Manager
    
    enum CartManager {
        static let baseUrl: URL = URL(string: "https://vast-dusk-53457.herokuapp.com/")!
        
        enum Parameters: String {
            case productId,
                 quantity,
                 userId
        }
        
        enum Add: String {
            case path = "cart.add"
        }
        
        enum Remove: String {
            case path = "cart.remove"
        }
        
        enum Pay: String {
            case path = "cart.pay"
        }
    }
    
}
