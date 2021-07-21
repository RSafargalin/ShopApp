//
//  UserProfileView.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 15.07.2021.
//

import Foundation
import UIKit

final class UserProfileView: UIView {
    
    // MARK: - Private Variables
    
    private let genderLabel: UILabel
    private let creditCardLabel: UILabel
    private let creditCardIcon: UIImageView
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        
        genderLabel = UILabel()
        creditCardLabel = UILabel()
        creditCardIcon = UIImageView(image: UIImage(systemName: "creditcard.fill"))
        super.init(frame: frame)
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func setGender(_ gender: Bool) {
        switch gender {
        case false:
            genderLabel.text = "Я считаю себя мужчиной"
            
        case true:
            genderLabel.text = "Я считаю себя женщиной"
        }
    }
    
    public func setCreditCatd(_ creditCardNumber: String) {
        creditCardLabel.text = creditCardNumber
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        
        backgroundColor = .systemBackground
        
        addSubview(genderLabel)
        addSubview(creditCardLabel)
        addSubview(creditCardIcon)
        
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        creditCardLabel.translatesAutoresizingMaskIntoConstraints = false
        creditCardIcon.translatesAutoresizingMaskIntoConstraints = false
        
        creditCardIcon.tintColor = .black
        
        NSLayoutConstraint.activate([
            genderLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            genderLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            genderLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            genderLabel.heightAnchor.constraint(equalToConstant: Constant.Sizes.Label.rawValue),
            
            creditCardIcon.topAnchor.constraint(equalTo: genderLabel.layoutMarginsGuide.bottomAnchor,
                                                constant: genderLabel.layoutMargins.bottom * 2),
            creditCardIcon.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            creditCardIcon.trailingAnchor.constraint(greaterThanOrEqualTo: creditCardLabel.leadingAnchor,
                                                     constant: -creditCardLabel.layoutMargins.left * 2),
            creditCardIcon.widthAnchor.constraint(equalToConstant: 36),
            creditCardIcon.heightAnchor.constraint(equalToConstant: 24),
            
            creditCardLabel.centerYAnchor.constraint(equalTo: creditCardIcon.centerYAnchor),
            creditCardLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            creditCardLabel.heightAnchor.constraint(equalToConstant: Constant.Sizes.Label.rawValue),
        ])
        
    }
}
