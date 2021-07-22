//
//  Constant.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 25.06.2021.
//

import Foundation
import UIKit
import Alamofire

struct Constant {
    
    // MARK: - Personal Area
    
    enum PersonalArea {
        static var baseUrl: URL = URL.getBaseURL()
        
        enum Parameters: String {
            case id = "id",
                 username = "username",
                 password = "password",
                 firstName = "firstName",
                 surname = "surname",
                 email = "email",
                 gender = "gender",
                 creditCard = "creditCard"
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
        static let baseUrl: URL = URL.getBaseURL()
        
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
        static let baseUrl: URL = URL.getBaseURL()
        
        enum Parameters: String {
            case id,
                 user,
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
        static let baseUrl: URL = URL.getBaseURL()
        
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
    
    // MARK: - Sizes
    
    enum Sizes: CGFloat {
        case TextField = 44,
             Label = 20
    }
    
    // MARK: - Margins
    
    enum Margins: CGFloat {
        case TextFieldFromLabel = 15
    }
}
