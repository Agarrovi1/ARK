//
//  FactsVC.swift
//  ARK-Project
//
//  Created by Liana Norman on 12/18/19.
//  Copyright © 2019 Liana Norman. All rights reserved.
//

import UIKit

class FactsVC: UIViewController {
    
    // MARK: - UI Objects
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Facts"
        label.font = UIFont(name: "Optima-ExtraBlack", size: 30)
        label.textColor = #colorLiteral(red: 0.2936059237, green: 0.2941584289, blue: 0.9735861421, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    lazy var factsTV: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
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
        view.addSubview(headerLabel)
        view.addSubview(factsTV)
    }
    
    private func addConstraints() {
        constrainHeaderLabel()
        constrainTableView()
    }
    
    private func delegation() {
        factsTV.delegate = self
        factsTV.dataSource = self
    }
    
    // MARK: - Constraint Methods
    private func constrainHeaderLabel() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 45), headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor), headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor), headerLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2)].forEach({$0.isActive = true})
    }
    
    private func constrainTableView() {
        factsTV.translatesAutoresizingMaskIntoConstraints = false
        
        [factsTV.topAnchor.constraint(equalTo: headerLabel.bottomAnchor), factsTV.leadingAnchor.constraint(equalTo: view.leadingAnchor), factsTV.trailingAnchor.constraint(equalTo: view.trailingAnchor), factsTV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)].forEach({$0.isActive = true})
    }

    
}

extension FactsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = factsTV.dequeueReusableCell(withIdentifier: "FactsTVCell", for: indexPath) as? FactsTVCell {
            cell.backgroundColor = .blue
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
