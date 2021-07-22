//
//  ReviewCell.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 21.07.2021.
//

import Foundation
import UIKit

class ReviewCell: UICollectionViewCell {
    
    static let identifier: String = "ReviewCell"
    
    let userNameLabel: UILabel = UILabel()
    let reviewMessageLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func awakeFromNib() {
        logging("first")
    }
    
    override func awakeFromNib() {
        configureUI()
        logging("second")
    }
    
    public func configure(from review: Review) {
        userNameLabel.text = review.user
        reviewMessageLabel.text = review.message
    }
    
    private func configureUI() {
        addSubview(userNameLabel)
        addSubview(reviewMessageLabel)
        
        userNameLabel.numberOfLines = 1
        userNameLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        reviewMessageLabel.numberOfLines = 7
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        reviewMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOpacity = 0.07
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.black.cgColor

        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
        
            userNameLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            userNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            reviewMessageLabel.topAnchor.constraint(equalTo: userNameLabel.layoutMarginsGuide.bottomAnchor,
                                                    constant: userNameLabel.layoutMargins.bottom * 2),
            reviewMessageLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            reviewMessageLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            reviewMessageLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.layoutMarginsGuide.bottomAnchor, constant: -self.layoutMargins.bottom),
            
        ])
    }
}
