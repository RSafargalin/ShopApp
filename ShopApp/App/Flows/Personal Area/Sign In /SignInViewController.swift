//
//  SignInViewController.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 11.07.2021.
//

import Foundation
import UIKit

// MARK: - SignInViewController

final class SignInViewController: UITextFieldsViewController {
    
    // MARK: - Private properties
    
    private lazy var router: Router = RouterImpl(for: self)
    private let personalArea: PersonalArea
    private var contentView: SignInView {
        return self.view as! SignInView
    }
    
    // MARK: - Life cycle
    
    override func loadView() {
        self.view = SignInView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        #if targetEnvironment(simulator)
        contentView.usernameContainerView.setText("LewisHamilton")
        contentView.passwordContainerView.setText("stillirise")
        #endif
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
        
        self.navigationItem.title = "Sign in..."
        
        let goToSignUpBarButtonItem = UIBarButtonItem(title: "Sign Up",
                                                      style: .plain,
                                                      target: self,
                                                      action: #selector(goToSignUp))
        
        self.navigationItem.rightBarButtonItem = goToSignUpBarButtonItem
        
        contentView.signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        super.setup()
        
    }
    
    @objc private func goToSignUp() {
        router.show(screen: .SignUp, with: .push, with: false)
    }
    
    @objc private func signIn() {
        
        guard let username = contentView.usernameContainerView.getText(),
              let password = contentView.passwordContainerView.getText(),
              !username.isEmpty,
              !password.isEmpty
        else {
            contentView.usernameContainerView.shake()
            contentView.passwordContainerView.shake()
            return
        }
        
        contentView.signInButton.set(.disabled)
        
        personalArea.login(userName: username, password: password) { [weak self] response in
            
            DispatchQueue.main.async {
                self?.contentView.signInButton.set(.enabled)
            }
            
            switch response.result {
            case .success(let result):
                print(result)
                DispatchQueue.main.async {
                    SessionData.shared.user = result.response.user
                    self?.router.show(screen: .UserProfile, with: .push, with: true)
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
