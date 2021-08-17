//
//  CartView.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 23.07.2021.
//

import Foundation
import UIKit
import SwiftUI

class CartView: UIView {
    
    // MARK: - Private Variables
    
    private var parent: CartViewControllerProtocol?
    
    private var products = [ProductOnCart]() {
        willSet {
            if newValue.isEmpty {
                payButton.set(.disabled)
            } else {
                payButton.set(.enabled)
            }
        }
    }
    
    private let tableView: UITableView
    
    private let totalCostLabel: UILabel
    private let totalCostValuesLabel: UILabel
    
    let payButton: UIButton
    
    private let viewPlugForEmptyProducts: ViewPlugForEmptyTable = ViewPlugForEmptyTable()
    
    
    // MARK: - Init
    
    required init(parent: CartViewControllerProtocol) {
        self.tableView = UITableView()
        self.totalCostLabel = UILabel()
        self.totalCostValuesLabel = UILabel()
        self.payButton = UIButton()
        self.parent = parent
        super.init(frame: CGRect())
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func update(products: [ProductOnCart], with totalCost: String) {
        DispatchQueue.main.async {
            self.products = products
            self.tableView.reloadData()
            self.totalCostValuesLabel.text = totalCost
        }
    }
    
    public func setPlugView(state: ViewPlugForEmptyTable.PlugViewState) {
        DispatchQueue.main.async {
            switch state {
            case .show(let state):
                self.viewPlugForEmptyProducts.setPlugView(state: .show(activityIndicatorState: state))
                
            case .hide:
                self.viewPlugForEmptyProducts.setPlugView(state: state)
            }
        }
    }
    
    // MARK: - Private Methods
 
    private func setup() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.identifier)
        
        configureUI()
        
    }
    
    private func configureUI() {
        
        backgroundColor = .systemBackground
        
        addSubview(tableView)
        addSubview(viewPlugForEmptyProducts)
        
        addSubview(totalCostLabel)
        addSubview(totalCostValuesLabel)
        addSubview(payButton)
        
        totalCostLabel.text = "Total Cost"
        totalCostLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        totalCostValuesLabel.text = "0 ₽"
        totalCostValuesLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        totalCostValuesLabel.textAlignment = .right
        
        payButton.backgroundColor = .accentColor
        payButton.setTitle("Pay", for: .normal)
        payButton.setTitleColor(.white, for: .normal)
        payButton.layer.cornerRadius = 10
        payButton.addTarget(self, action: #selector(pay), for: .touchUpInside)
        payButton.set(.disabled)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        viewPlugForEmptyProducts.translatesAutoresizingMaskIntoConstraints = false
        
        totalCostLabel.translatesAutoresizingMaskIntoConstraints = false
        totalCostValuesLabel.translatesAutoresizingMaskIntoConstraints = false
        payButton.translatesAutoresizingMaskIntoConstraints = false
    
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            
            totalCostLabel.topAnchor.constraint(equalTo: tableView.layoutMarginsGuide.bottomAnchor,
                                                constant: tableView.layoutMargins.bottom * 2),
            totalCostLabel.topAnchor.constraint(equalTo: viewPlugForEmptyProducts.layoutMarginsGuide.bottomAnchor,
                                                constant: viewPlugForEmptyProducts.layoutMargins.bottom * 2),
            totalCostLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            totalCostLabel.trailingAnchor.constraint(equalTo: totalCostValuesLabel.leadingAnchor),
            totalCostLabel.heightAnchor.constraint(equalToConstant: 20),
            totalCostLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4, constant: -self.layoutMargins.left * 4),
            
            totalCostValuesLabel.topAnchor.constraint(equalTo: tableView.layoutMarginsGuide.bottomAnchor,
                                                      constant: tableView.layoutMargins.bottom * 2),
            totalCostValuesLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            totalCostValuesLabel.heightAnchor.constraint(equalToConstant: 20),
            
            payButton.topAnchor.constraint(equalTo: totalCostLabel.layoutMarginsGuide.bottomAnchor,
                                           constant: payButton.layoutMargins.bottom * 4),
            payButton.topAnchor.constraint(equalTo: totalCostValuesLabel.layoutMarginsGuide.bottomAnchor,
                                           constant: payButton.layoutMargins.bottom * 4),
            payButton.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            payButton.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            payButton.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor,
                                              constant: -self.layoutMargins.bottom * 4),
            payButton.heightAnchor.constraint(equalToConstant: 44),
            
            tableView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            viewPlugForEmptyProducts.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            viewPlugForEmptyProducts.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewPlugForEmptyProducts.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
        ])
        
    }
    
    @objc private func removeProduct(_ sender: UIButton) {
        DispatchQueue.main.async {
            sender.isEnabled = false
            guard let controller = self.parent else { return }
            controller.removeFromCart(product: sender.tag)
            
        }
    }
    
    @objc private func pay() {
        DispatchQueue.main.async {
            guard let controller = self.parent else { return }
            controller.pay()
        }
    }
    
}

// MARK: - ProductProfileView + UICollectionViewDelegate, ProductProfileView + UICollectionViewDataSource

extension CartView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products[indexPath.item]
        if let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.identifier,
                                                         for: indexPath) as? CartCell {
            cell.configure(from: product)
            cell.productRemoveButton.addTarget(self, action: #selector(removeProduct(_:)), for: .touchUpInside)
            return cell

        } else {

            let cell = CartCell()
            cell.productRemoveButton.addTarget(cell.productRemoveButton,
                                               action: #selector(removeProduct(_:)),
                                               for: .touchUpInside)
            cell.configure(from: product)
            return cell

        }
    }
    
}

struct PaymentInfoControl_Preview: PreviewProvider {
    static var previews: some View {
        let view = CartView(parent: CartViewController())
        return UIViewPreview(view)
            .previewLayout(.device)
    }
}
