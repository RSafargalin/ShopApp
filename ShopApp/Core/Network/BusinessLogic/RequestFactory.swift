//
//  RequestFactory.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 22.06.2021.
//

import Foundation
import Alamofire

class RequestFactory {
    
    private func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    private lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()
    
    private let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makePersonalAreaRequestFatory() -> PersonalAreaRequestFactory {
        let errorParser = makeErrorParser()
        return PersonalArea(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
}
