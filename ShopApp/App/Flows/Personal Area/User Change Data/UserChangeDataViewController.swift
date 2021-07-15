//
//  UserChangeDataViewController.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 15.07.2021.
//

import Foundation
import UIKit

// MARK: - UserChangeDataViewController

final class UserChangeDataViewController: UITextFieldsViewController {
    
    // MARK: - Private properties
    
    private var delegate: UserProfileViewControllerDelegate?
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
    
    init(_ delegate: UserProfileViewControllerDelegate) {
        let requestFactory = RequestFactory()
        personalArea = requestFactory.fetchRequestFactory()
        self.delegate = delegate
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    override func setup() {
        
        self.navigationItem.title = "Change user data..."
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        contentView.signUpButton.setTitle("Save", for: .normal)
        contentView.signUpButton.addTarget(self, action: #selector(changeData), for: .touchUpInside)
        
        contentView.usernameContainerView.setText(SessionData.shared.user.username)
        contentView.passwordContainerView.setText(SessionData.shared.user.password)
        contentView.firstNameContainerView.setText(SessionData.shared.user.firstName)
        contentView.surnameContainerView.setText(SessionData.shared.user.surname)
        contentView.emailContainerView.setText(SessionData.shared.user.email)
        contentView.creditCardContainerView.setText(SessionData.shared.user.creditCard)
        contentView.sexContainerView.setSelectedSex(SessionData.shared.user.gender)
        
        super.setup()
        
    }
    
    @objc private func changeData() {
        
        contentView.signUpButton.set(.disabled)
        
        let gender = contentView.sexContainerView.getSelectedSex()
        var userData = ChangeQueryData(id: SessionData.shared.user.id,
                                       username: nil,
                                       password: nil,
                                       firstName: nil,
                                       surname: nil,
                                       email: nil,
                                       gender: gender,
                                       creditCard: nil)
        
        if let username = contentView.usernameContainerView.getText(), !username.isEmpty {
            userData.username = username
        }
        
        if let password = contentView.passwordContainerView.getText(), !password.isEmpty {
            userData.password = password
        }
        
        if let firstName = contentView.firstNameContainerView.getText(), !firstName.isEmpty {
            userData.firstName = firstName
        }
        
        if let surname = contentView.surnameContainerView.getText(), !surname.isEmpty {
            userData.surname = surname
        }
        
        if let email = contentView.emailContainerView.getText(), !email.isEmpty {
            userData.email = email
        }
        
        if let creditCard = contentView.creditCardContainerView.getText(), !creditCard.isEmpty {
            userData.creditCard = creditCard
        }
        
        personalArea.changeData(userData) { [weak self] response in
            DispatchQueue.main.async {
                self?.contentView.signUpButton.set(.enabled)
                
                switch response.result {
                case .success(let result):
                    SessionData.shared.user = result.response.user
                    print(result.response.user)
                    self?.delegate?.updateUserData()
                    self?.navigationController?.popViewController(animated: true)
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
}
