//
//  ValidationManager.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 24.07.2021.
//

import Foundation

struct ValidationManager {
    
    // MARK: - Enums
    
    enum RegExpType {
        case IntAndNotZero
    }
    
    // MARK: - Public Methods
    
    public func isValid(value: String, for type: RegExpType) -> Bool {
        
        var regularExpression: NSRegularExpression? = SessionData.RegularExpressions.IntAndNotZero
        
        if regularExpression == nil {
            switch fetchRegExp(for: type) {
            case .success(let regExp):
                regularExpression = regExp
             
            case .failure(_):
                return false
            }
        }
        
        guard let regularExpression = regularExpression else { return false }
        
        let range = NSRange(location: 0, length: value.utf16.count)
        let result = regularExpression.firstMatch(in: value, options: [], range: range) != nil
        
        return result
    }
    
    public func fetchRegularExpression(for type: RegExpType) -> NSRegularExpression? {
        let fetchRegExpResult = fetchRegExp(for: type)
        switch fetchRegExpResult {
        case .success(let regExp):
            return regExp
            
        default:
            return nil
        }
    }
    
    // MARK: - Private Methods
    
    private func fetchRegExp(for type: RegExpType) -> Result<NSRegularExpression, RegularExpressionErrors> {
        do {
            switch type {
            case .IntAndNotZero:
                return .success(try NSRegularExpression(pattern: "^(?!0)[\\d]+$"))
            }
        } catch {
            return .failure(.FailedToCreateRegularExpression)
        }
    }
    
    
    
}
