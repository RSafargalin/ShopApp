//
//  SignUpView.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 12.07.2021.
//

import Foundation
import UIKit

final class ChangeUserDataView: UIView, ContentView {
    
    // MARK: - Public Variables
    
    let scrollView: UIScrollView
    let usernameContainerView: ContainerForTextFieldWithLabelProtocol
    let passwordContainerView: ContainerForTextFieldWithLabelProtocol
    let firstNameContainerView: ContainerForTextFieldWithLabelProtocol
    let surnameContainerView: ContainerForTextFieldWithLabelProtocol
    let emailContainerView: ContainerForTextFieldWithLabelProtocol
    let sexContainerView: DefaultSexSelectionContainerView
    let creditCardContainerView: ContainerForTextFieldWithLabelProtocol
    let signUpButton: UIButton
    
    // MARK: - Private Variables
    
    private let stackView: UIStackView
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        
        stackView = UIStackView()
        scrollView = UIScrollView()
        usernameContainerView = DefaultContainerForTextFieldWithLabel(with: "Login", and: "Login...")
        passwordContainerView = DefaultContainerForTextFieldWithLabel(with: "Password", and: "Password...")
        firstNameContainerView = DefaultContainerForTextFieldWithLabel(with: "First name", and: "First name...")
        surnameContainerView = DefaultContainerForTextFieldWithLabel(with: "Surname", and: "Surname...")
        emailContainerView = DefaultContainerForTextFieldWithLabel(with: "Email", and: "Email...")
        sexContainerView = DefaultSexSelectionContainerView()
        creditCardContainerView = DefaultContainerForTextFieldWithLabel(with: "Credit card number",
                                                                        and: "Credit card number...")
        signUpButton = UIButton()
        super.init(frame: frame)
        self.configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        backgroundColor = .systemBackground
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.spacing = Constant.Sizes.Default.spacing.rawValue
        stackView.addArrangedSubview(usernameContainerView)
        stackView.addArrangedSubview(emailContainerView)
        stackView.addArrangedSubview(firstNameContainerView)
        stackView.addArrangedSubview(surnameContainerView)
        stackView.addArrangedSubview(sexContainerView)
        stackView.addArrangedSubview(passwordContainerView)
        stackView.addArrangedSubview(creditCardContainerView)
        stackView.addArrangedSubview(signUpButton)
    
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.tintColor = .white
        signUpButton.backgroundColor = .accentColor
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.layer.cornerRadius = Constant.Sizes.Default.Layer.cornerRadius.rawValue
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                               constant: self.layoutMargins.left * 2),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,
                                                constant: -self.layoutMargins.left * 2),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor,
                                           constant: self.layoutMargins.top),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,
                                              constant: -self.layoutMargins.top * 2),
            
            signUpButton.heightAnchor.constraint(equalToConstant: Constant.Sizes.Default.Button.TapAreaSize.rawValue),
        ])

    }
}
