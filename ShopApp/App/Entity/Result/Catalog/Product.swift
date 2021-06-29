//
//  Product.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 29.06.2021.
//

import Foundation

struct ProductResult: Codable {

    let result: Int?
    let id: Int?
    let name: String
    let price: Int
    let description: String?
    
    enum ProductKeys: String, CodingKey {
        case result = "result",
             id = "id_product",
             name = "product_name",
             price = "price",
             anotherPrice = "product_price",
             description = "product_description"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductKeys.self)
        result = try? container.decode(Int.self, forKey: .result)
        id = try? container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        price = try (try? container.decode(Int.self, forKey: .price)) ?? (try container.decode(Int.self, forKey: .anotherPrice))
        description = try? container.decode(String.self, forKey: .description)
    }
}
