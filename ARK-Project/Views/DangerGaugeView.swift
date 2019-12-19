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
    var arrowIsSet = false
    var warningImage = UIImageView(image: #imageLiteral(resourceName: "icons8-error"))
    
    private func setGradientView() {
        addSubview(gradientView)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: topAnchor,constant: 50),
            gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    private func setWarningConstraints() {
        addSubview(warningImage)
        warningImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            warningImage.bottomAnchor.constraint(equalTo: gradientView.topAnchor),
            warningImage.centerXAnchor.constraint(equalTo: centerXAnchor)])
    }
    private func setArrow() {
        arrow.tintColor = .black
        gradientView.addSubview(arrow)
        arrow.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrow.centerYAnchor.constraint(equalTo: gradientView.centerYAnchor),
            arrow.trailingAnchor.constraint(equalTo: gradientView.centerXAnchor),
            arrow.leadingAnchor.constraint(equalTo: gradientView.leadingAnchor)])
        arrowIsSet = true
    }
    func changePositionOfArrow(dangerLevel: Int) {
        if !arrowIsSet {
            setArrow()
        }
        
        switch dangerLevel {
        case 3:
            arrow.transform = CGAffineTransform(translationX: 0, y: -27)
        case 2:
            arrow.transform = CGAffineTransform(translationX: 0, y: -32)
        case 7:
            arrow.transform = CGAffineTransform(translationX: 0, y: 62)
        default:
            return
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setGradientView()
        setWarningConstraints()
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
    private func changeGauge() {
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
