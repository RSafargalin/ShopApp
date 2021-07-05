//
//  MainViewController.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 03.07.2021.
//

import Foundation
import UIKit

final class MainViewController: UIViewController {
    
    private let requestFactory = RequestFactory()
    private lazy var personalArea: PersonalArea = requestFactory.fetchRequestFactory()
    private lazy var catalog: Catalog = requestFactory.fetchRequestFactory()
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        login()
        logout()
        checkIn()
        changeData()
        
        fetchAllProducts()
        fetchProductForId()
    }
    
    private func setup() -> Void {
        view.backgroundColor = .systemBackground
    }
    
    private func login() {
        personalArea.login(userName: "LewisHamilton", password: "stillirise") { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func logout() {
        personalArea.logout(userId: 1) { response in
            switch response.result {
            case .success(let logout):
                print(logout)

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func checkIn() {
        let userData = UserData(name: "geekbrains", password: "password", email: "geekbrains@mail.com", gender: false, creditCard: "none", bio: "none")
        personalArea.checkIn(userData) { response in
            switch response.result {
            case .success(let checkIn):

                print(checkIn)

            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func changeData() {
        let user = User(id: 1, name: "geekbrains", password: "password", email: "geekbrains@mail.com", gender: false, creditCard: "none", bio: "none")
        personalArea.changeData(user) { response in
            switch response.result {
            case .success(let changeData):

                print(changeData)

            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchAllProducts() {
        catalog.fetchAll { response in
            switch response.result {
            case .success(let products):

                print(products)

            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchProductForId() {
        catalog.fetchProduct(for: 1) { response in
            switch response.result {
            case .success(let product):

                print(product)

            case .failure(let error):
                print(error)
            }
        }
    }
    
}
