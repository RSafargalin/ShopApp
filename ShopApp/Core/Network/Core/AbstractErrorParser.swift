//
//  AbstractErrorParser.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 22.06.2021.
//

import Foundation

protocol AbstractErrorParser {
    
    func parse(_ result: Error) -> Error
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
    
}
