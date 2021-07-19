//
//  ProductCell.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 19.07.2021.
//

import Foundation
import UIKit

class ProductCell: UITableViewCell {
    
    static let identifier: String = "ProductCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: ProductCell.identifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(from product: Product) {
        if let textLabel = textLabel, let detailTextLabel = detailTextLabel {
            textLabel.text = product.name
            detailTextLabel.text = "\(product.price) ₽"
            accessoryType = .disclosureIndicator
        }
    }
}
