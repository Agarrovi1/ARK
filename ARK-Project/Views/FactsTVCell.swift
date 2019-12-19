//
//  FactsTVCell.swift
//  ARK-Project
//
//  Created by Liana Norman on 12/18/19.
//  Copyright © 2019 Liana Norman. All rights reserved.
//

import UIKit

class FactsTVCell: UITableViewCell {

    lazy var factLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Optima-Bold", size: 23)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.backgroundColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        constrainFactLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func addSubviews() {
        contentView.addSubview(factLabel)
    }
    
    // MARK: - Constraint Methods
    private func constrainFactLabel() {
        factLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [factLabel.topAnchor.constraint(equalTo: contentView.topAnchor), factLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), factLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor), factLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)].forEach({$0.isActive = true})
    }
    
}
