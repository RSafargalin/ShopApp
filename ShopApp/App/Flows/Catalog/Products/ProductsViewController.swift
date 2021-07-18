//
//  ProductsViewController.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 16.07.2021.
//

import Foundation
import UIKit

class ProductsViewController: UITableViewController {
    
    // MARK: - Private Variables
    
    private let catalogManager: Catalog
    private let identifier = "Cell"
    private var products = [Product]()
    
    // MARK: - Init
    
    init() {
        let requestFactory = RequestFactory()
        catalogManager = requestFactory.fetchRequestFactory()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProducts()
    }
    
    // MARK: - Private methods
    
    private func fetchProducts() {
        
        catalogManager.fetchAll { [weak self] response in
            switch response.result {
            case .success(let result):
                DispatchQueue.main.async {
                    self?.products = result.response.products
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    // MARK: - ProductsViewController + UITableViewDelegate, ProductsViewController + UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: identifier)
        let product = products[indexPath.row]
        
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = "\(product.price) ₽"
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
}
