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
    private lazy var reviewsManager: ReviewManager = requestFactory.fetchRequestFactory()
    private lazy var cartManager: CartManager = requestFactory.fetchRequestFactory()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        // Personal Area
        
        login()
        logout()
        checkIn()
        changeData()
        
        // Catalog
        
//        fetchAllProducts()
//        fetchProductForId()

        // Reviews
        
//        fetchReviewsForProduct()
//        addReviewForProduct()
//        removeReviewForProduct()
        
        // Cart
//        sleep(2)
//        addProductToCart(productId: 1, quantity: 2)
//        sleep(2)
//        addProductToCart(productId: 2, quantity: 1)
//        sleep(2)
//        removeProductToCart(productId: 2)
//        sleep(2)
//        payCart()
    }
    
    private func setup() -> Void {
        view.backgroundColor = .systemBackground
    }
    
    private func login() {
        personalArea.login(userName: "LewisHamilton", password: "stillirise") { response in
            switch response.result {
            case .success(let login):
                print(login)
                SessionData.shared.user = login.response.user
                
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
        let userData = UserData(name: "geekbrains", password: "password", email: "geekbrains@mail.com", gender: false, creditCard: "none", bio: "none", cart: [:])
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
        let user = User(id: 1, name: "geekbrains", password: "password", email: "geekbrains@mail.com", gender: false, creditCard: "none", bio: "none", cart: [:])
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
        let productId = 1
        catalog.fetchProduct(for: productId) { response in
            switch response.result {
            case .success(let product):

                print(product)

            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchReviewsForProduct() {
        let productId = 1
        reviewsManager.fetchAllReviews(for: productId) { response in
            switch response.result {
            case .success(let result):
                print(result.response.reviews)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func removeReviewForProduct() {
        let productId = 1
        let reviewId = 12
        reviewsManager.removeReview(with: reviewId, for: productId) { response in
            switch response.result {
            case .success(let result):
                print(result.response)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func addReviewForProduct() {
        let productId = 1
        let userId = 1
        let message = "Good product"
        reviewsManager.addReview(for: productId, with: userId, and: message) { response in
            switch response.result {
            case .success(let result):
                print(result.response)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func addProductToCart(productId: Int, quantity: Int) {
        
        cartManager.add(productId: productId, with: quantity) { response in
            switch response.result {
            case .success(let result):
                print(result.response)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    private func removeProductToCart(productId: Int) {
        
        cartManager.remove(productId: productId) { response in
            switch response.result {
            case .success(let result):
                print(result.response)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    private func payCart() {
        
        cartManager.pay() { response in
            switch response.result {
            case .success(let result):
                print(result.response)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
