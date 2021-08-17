//
//  RegularExpressionErrors.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 24.07.2021.
//

import Foundation

enum RegularExpressionErrors: Error {
    case FailedToCreateRegularExpression
}

extension RegularExpressionErrors: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .FailedToCreateRegularExpression:
            return "Failed to create regular expression"
            
        }
    }

}
