//
//  DefaultSexSelectionContainerView.swift.swift
//  ShopApp
//
//  Created by Ruslan Safargalin on 13.07.2021.
//

import Foundation
import UIKit

class DefaultSexSelectionContainerView: UIView {
    
    // MARK: - Private property
    
    private let label: UILabel = UILabel()
    private let segmentedControl: UISegmentedControl = UISegmentedControl(items: ["Мужчиной", "Женщиной"])
    
    // MARK: - Init
    
    required init() {
        super.init(frame: CGRect())
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("\(#file) \(#line)")
    }
    
    // MARK: - Public methods
    
    func getSelectedSex() -> Bool {
        return segmentedControl.selectedSegmentIndex == 0 ? false : true
    }
    
    func setSelectedSex(_ gender: Bool) {
        gender == false ? (segmentedControl.selectedSegmentIndex = 0) : (segmentedControl.selectedSegmentIndex = 1)
    }
    
    // MARK: - Private methods
    
    private func setup() {
        
        addSubview(label)
        addSubview(segmentedControl)
        
        label.text = "Я, считаю себя"
        
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        configureUI()
        
    }
    
    private func configureUI() {

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: segmentedControl.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            label.trailingAnchor.constraint(greaterThanOrEqualTo: segmentedControl.layoutMarginsGuide.trailingAnchor,
                                            constant: label.layoutMargins.right * 2),
            label.heightAnchor.constraint(equalToConstant: Constant.Sizes.Label.rawValue),
            
            segmentedControl.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
        ])
        
    }
}
