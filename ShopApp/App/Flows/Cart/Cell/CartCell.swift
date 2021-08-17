//
//  CartCell.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 23.07.2021.
//

import Foundation
import UIKit

class CartCell: UITableViewCell {

    static let identifier: String = "CartCell"
    
    let productName: UILabel = UILabel()
    let productPriceAndCount: UILabel = UILabel()
    let productRemoveButton: UIButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(from product: ProductOnCart) {
        productName.text = product.name
        productPriceAndCount.text = product.getCountWithCostInStringFormat()
        productRemoveButton.tag = product.id
    }
    
    private func configureUI() {
        addSubview(productName)
        addSubview(productPriceAndCount)
        addSubview(productRemoveButton)
        
//        selectionStyle = .none
        
        contentView.isUserInteractionEnabled = false
        
        productName.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        productName.numberOfLines = 2
        
        productPriceAndCount.font = UIFont.systemFont(ofSize: 15, weight: .light)
        productPriceAndCount.textColor = .lightGray
        
        productName.translatesAutoresizingMaskIntoConstraints = false
        productPriceAndCount.translatesAutoresizingMaskIntoConstraints = false
        productRemoveButton.translatesAutoresizingMaskIntoConstraints = false
    
        productRemoveButton.setImage(UIImage(systemName: "cart.fill.badge.minus"), for: .normal)
        
        NSLayoutConstraint.activate([
        
            productName.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            productName.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            productName.trailingAnchor.constraint(
                lessThanOrEqualTo: productRemoveButton.layoutMarginsGuide.leadingAnchor,
                constant: -productRemoveButton.layoutMargins.left * 2),
            productName.heightAnchor.constraint(equalToConstant: 20),
            
            productPriceAndCount.topAnchor.constraint(equalTo: productName.layoutMarginsGuide.bottomAnchor,
                                                    constant: productName.layoutMargins.bottom * 2),
            productPriceAndCount.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            productPriceAndCount.trailingAnchor.constraint(
                lessThanOrEqualTo: productRemoveButton.layoutMarginsGuide.leadingAnchor,
                constant: -productRemoveButton.layoutMargins.left * 2),
            productPriceAndCount.bottomAnchor.constraint(lessThanOrEqualTo: self.layoutMarginsGuide.bottomAnchor),
            
            productRemoveButton.centerYAnchor.constraint(equalTo: self.layoutMarginsGuide.centerYAnchor),
            productRemoveButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            productRemoveButton.widthAnchor.constraint(equalTo: productRemoveButton.heightAnchor, multiplier: 1),
            productRemoveButton.widthAnchor.constraint(equalToConstant: 44)
            
            
        ])
    }
    
    override func prepareForReuse() {
        productName.text = ""
        productRemoveButton.backgroundColor = .systemBackground
        productRemoveButton.isEnabled = true
        productPriceAndCount.text = ""
    }
}
