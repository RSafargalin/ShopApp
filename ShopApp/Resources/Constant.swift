//
//  Constant.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 25.06.2021.
//

import Foundation

struct Constant {
    
    // MARK: Personal Area
    
    enum PersonalArea {
        static let baseUrl: URL = URL(string: "https://vast-dusk-53457.herokuapp.com/")!
        
        enum Parameters: String {
            case id = "id",
                 username = "username",
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
    
    // MARK: Catalog
    
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
}
