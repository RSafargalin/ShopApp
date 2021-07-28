//
//  CartViewController.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 23.07.2021.
//

import Foundation
import UIKit
import FirebaseAnalytics

protocol CartViewControllerProtocol {
    
    func removeFromCart(product id: Int)
    func pay()
    
}

class CartViewController: UIViewController {
    
    // MARK: - Private Variables
    private let cartManager: CartManager
    private var products = [ProductOnCart]()
    private var contentView: CartView {
        return transformView(to: CartView.self)
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = CartView(parent: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchReviewForProduct()
    }
    
    // MARK: - Init
    
    init() {
        let requestFactory = RequestFactory()
        self.cartManager = requestFactory.fetchRequestFactory()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        self.navigationItem.title = "Cart"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func fetchReviewForProduct() {
        contentView.setPlugView(state: .show(activityIndicatorState: .show))
        cartManager.fetchProductsOnCart { [weak self] response in
            switch response.result {
            case .success(let result):
                self?.products = result.response.products
                DispatchQueue.main.async {
                    guard let products = self?.products, !products.isEmpty else {
                        self?.contentView.setPlugView(state: .show(activityIndicatorState: .hide))
                        self?.contentView.update(products: [], with: "0 ₽")
                        return
                    }
                    self?.contentView.setPlugView(state: .hide)
                    let totalCost = self?.fetchTotalCostInStringFormat(for: products) ?? "0 ₽"
                    self?.contentView.update(products: products, with: totalCost)
                }
                
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
    }
    
    private func fetchTotalCostInStringFormat(for products: [ProductOnCart]) -> String {
        var totalCost = 0
        products.forEach { product in
            totalCost += product.getTotalCost()
        }
        return "\(totalCost) ₽"
    }
}

extension CartViewController: CartViewControllerProtocol {
    
    func removeFromCart(product id: Int) {
        cartManager.remove(productId: id) { [weak self] response in
            switch response.result {
            case .success(_):
                Analytics.logEvent(AnalyticsEventRemoveFromCart, parameters: [
                    AnalyticsParameterMethod: self?.method as Any,
                    "username" : SessionData.shared.user.username,
                    "productId" : id
                ])
                self?.products.removeAll(where: { $0.id == id })
                guard let products = self?.products else { return }
                let totalCost = self?.fetchTotalCostInStringFormat(for: products) ?? "0 ₽"
                DispatchQueue.main.async {
                    if products.isEmpty {
                        self?.contentView.setPlugView(state: .show(activityIndicatorState: .hide))
                    }
                    self?.contentView.update(products: products, with: totalCost)
                }
                
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
    }
    
    func pay() {
        
        cartManager.pay { [weak self] response in
            switch response.result {
            case .success(let result):
                Analytics.logEvent("Pay", parameters: [
                    AnalyticsParameterMethod: self?.method as Any,
                    "username" : SessionData.shared.user.username
                ])
                logging(result.response.totalCost)
                self?.products = []
                DispatchQueue.main.async {
                    guard let products = self?.products else { return }
                    if products.isEmpty {
                        self?.contentView.setPlugView(state: .show(activityIndicatorState: .hide))
                    }
                    self?.contentView.update(products: products, with: "0 ₽")
                }
                // TODO: push view controller
                break
                
            case .failure(let error):
                logging(error.localizedDescription)
            }
        }
        
    }
}
