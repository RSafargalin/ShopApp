//
//  BaseResponse.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 03.07.2021.
//

import Foundation

struct Response<ResponseType: Codable>: Codable {
    var response: ResponseType
}
