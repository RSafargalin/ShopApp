//
//  ProductsView.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 19.07.2021.
//

import Foundation
import UIKit

class ProductsView: UIView {
    
    // MARK: - Public Variables
    
    weak var parent: UIViewController?
    
    // MARK: - Private Variables
    
    private let tableView: UITableView
    private var products = [Product]()
    private let viewPlugForEmptyProducts: ViewPlugForEmptyTable = ViewPlugForEmptyTable()
    
    // MARK: - Init
    
    init(parent: UIViewController) {
        
        tableView = UITableView()
        
        super.init(frame: CGRect())
        configureUI()
        self.parent = parent
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func update(products: [Product]) {
        DispatchQueue.main.async {
            self.products = products
            self.tableView.reloadData()
        }
    }
    
    public func setPlugView(state: ViewPlugForEmptyTable.PlugViewState) {
        switch state {
        case .show(let state):
            viewPlugForEmptyProducts.setPlugView(state: .show(activityIndicatorState: state))
            
        case .hide:
            viewPlugForEmptyProducts.setPlugView(state: state)
        }
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        
        backgroundColor = .systemBackground
        
        addSubview(tableView)
        addSubview(viewPlugForEmptyProducts)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        viewPlugForEmptyProducts.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            viewPlugForEmptyProducts.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            viewPlugForEmptyProducts.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewPlugForEmptyProducts.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            viewPlugForEmptyProducts.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
        ])
        
    }
    
}

// MARK: - ProductsView + UITableViewDelegate, ProductsView + UITableViewDataSource

extension ProductsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell: ProductCell?
        
        if let productCell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier,
                                                           for: indexPath) as? ProductCell {
            cell = productCell
        } else {
            cell = ProductCell()
        }
        
        let product = products[indexPath.row]
        
        guard let cell = cell else {
            let cell = ProductCell()
            cell.configure(from: product)
            return cell
        }
        
        cell.configure(from: product)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let controller = parent else { return }
        let product = products[indexPath.item]
        RouterImpl(for: controller).show(screen: .Profile(product: product), with: .push)
    }
    
}
