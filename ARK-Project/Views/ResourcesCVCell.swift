//
//  ResourcesCVCell.swift
//  ARK-Project
//
//  Created by Liana Norman on 12/18/19.
//  Copyright © 2019 Liana Norman. All rights reserved.
//

import UIKit

class ResourcesCVCell: UICollectionViewCell {
    
    // MARK: - UI Objects
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Optima-ExtraBlack", size: 18)
        label.textColor = #colorLiteral(red: 0.2936059237, green: 0.2941584289, blue: 0.9735861421, alpha: 1)
        label.backgroundColor = .yellow
        return label
    }()
    
    lazy var cellImageView: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .green
        return img
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        constrainLabel()
        constrainCellImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func addSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(cellImageView)
    }
    
    // MARK: - Constraint Methods
    private func constrainLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor), nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor), nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2)].forEach({$0.isActive = true})
    }
    
    private func constrainCellImageView() {
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        
        [cellImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor), cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor), cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor), cellImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)].forEach({$0.isActive = true})
    }
    
    
}
