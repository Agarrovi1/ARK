//
//  DangerGaugeView.swift
//  ARK-Project
//
//  Created by Liana Norman on 12/18/19.
//  Copyright © 2019 Liana Norman. All rights reserved.
//

import UIKit

class DangerGaugeView: UIView {
    //MARK: - Objects
    var gradientView = GradientView()
    var arrow = UIImageView(image: UIImage(systemName: "arrow.right"))
    
    func setGradientView() {
        addSubview(gradientView)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: topAnchor,constant: 50),
            gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    func setArrow() {
        arrow.tintColor = .black
        gradientView.addSubview(arrow)
        arrow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrow.centerYAnchor.constraint(equalTo: gradientView.centerYAnchor),
            arrow.trailingAnchor.constraint(equalTo: gradientView.centerXAnchor),
            arrow.leadingAnchor.constraint(equalTo: gradientView.leadingAnchor)])
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setGradientView()
        setArrow()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class GradientView: UIView {
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let gradientLayer = layer as? CAGradientLayer else {
            return
        }
        gradientLayer.colors = [
            UIColor.red.cgColor,
            UIColor.orange.cgColor,
            UIColor.yellow.cgColor,
            UIColor.green.cgColor,
            UIColor.systemGreen.cgColor
        ]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func changeGauge(dangerlevel: Int) {
        guard let gradientLayer = layer as? CAGradientLayer else {
            return
        }
        gradientLayer.colors = [
            UIColor.red.cgColor,
            UIColor.orange.cgColor,
            UIColor.yellow.cgColor,
            UIColor.green.cgColor,
            UIColor.systemGreen.cgColor
        ]
    }
}
