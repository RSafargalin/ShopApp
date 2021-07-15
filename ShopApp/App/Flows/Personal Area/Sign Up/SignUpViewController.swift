//
//  SignUpViewController.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 12.07.2021.
//

import Foundation
import UIKit

// MARK: - SignInViewController

final class SignUpViewController: UITextFieldsViewController {

    // MARK: - Private properties
    
    private let personalArea: PersonalArea
    private var contentView: SignUpView {
        return self.view as! SignUpView
    }
    
    // MARK: - Life cycle
    
    override func loadView() {
        self.view = SignUpView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Init
    
    override init() {
        let requestFactory = RequestFactory()
        personalArea = requestFactory.fetchRequestFactory()
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    override func setup() {
        
        self.navigationItem.title = "Sign Up..."
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        contentView.signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        super.setup()
        
    }
    
    @objc private func signUp() {
        
        contentView.signUpButton.set(.disabled)
        
        guard let username = contentView.usernameContainerView.getText(),
              let password = contentView.passwordContainerView.getText(),
              let firstName = contentView.firstNameContainerView.getText(),
              let surname = contentView.surnameContainerView.getText(),
              let email = contentView.emailContainerView.getText(),
              let creditCard = contentView.creditCardContainerView.getText(),
              !username.isEmpty,
              !password.isEmpty,
              !firstName.isEmpty,
              !surname.isEmpty,
              !email.isEmpty,
              !creditCard.isEmpty
        else {
            contentView.usernameContainerView.shake()
            contentView.passwordContainerView.shake()
            contentView.firstNameContainerView.shake()
            contentView.surnameContainerView.shake()
            contentView.creditCardContainerView.shake()
            contentView.signUpButton.set(.enabled)
            return
        }
        
        let gender = contentView.sexContainerView.getSelectedSex()
        
        let userData = UserData(username: username,
                                password: password,
                                firstName: firstName,
                                surname: surname,
                                email: email,
                                gender: gender,
                                creditCard: creditCard,
                                cart: [:])
        
        
        
        personalArea.checkIn(userData) { [weak self] response in
            self?.contentView.signUpButton.set(.enabled)
            
            switch response.result {
            case .success(let result):
                print(result)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
