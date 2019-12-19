//
//  FactsVC.swift
//  ARK-Project
//
//  Created by Liana Norman on 12/18/19.
//  Copyright © 2019 Liana Norman. All rights reserved.
//

import UIKit

class FactsVC: UIViewController {
    
    var states = "NY"
    // MARK: - UI Objects
    lazy var headerImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "tornado")
        return img
    }()
    
    lazy var factsTV: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .black
        tv.register(FactsTVCell.self, forCellReuseIdentifier: "FactsTVCell")
        return tv
    }()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
        delegation()
    }
    
    // MARK: - Private Methods
    private func addSubviews() {
        view.addSubview(headerImage)
        view.addSubview(factsTV)
    }
    
    private func addConstraints() {
        constrainHeaderImage()
        constrainTableView()
    }
    
    private func delegation() {
        factsTV.delegate = self
        factsTV.dataSource = self
    }
    
    // MARK: - Constraint Methods
    private func constrainHeaderImage() {
        headerImage.translatesAutoresizingMaskIntoConstraints = false
        
        [headerImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), headerImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.20), headerImage.heightAnchor.constraint(equalTo: headerImage.widthAnchor), headerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainTableView() {
        factsTV.translatesAutoresizingMaskIntoConstraints = false
        
        [factsTV.topAnchor.constraint(equalTo: headerImage.bottomAnchor), factsTV.leadingAnchor.constraint(equalTo: view.leadingAnchor), factsTV.trailingAnchor.constraint(equalTo: view.trailingAnchor), factsTV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)].forEach({$0.isActive = true})
    }

    
}

extension FactsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NY.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = factsTV.dequeueReusableCell(withIdentifier: "FactsTVCell", for: indexPath) as? FactsTVCell {
            switch states {
            case "NY":
                cell.factLabel.text = NY[indexPath.row]
            case "FL":
                cell.factLabel.text = FL[indexPath.row]
            case "NV":
                cell.factLabel.text = NV[indexPath.row]
            default:
                break
                
            }
            return cell
        }
        return UITableViewCell()
    }
    
    
}

extension FactsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
