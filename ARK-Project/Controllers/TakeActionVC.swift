//
//  TakeActionVC.swift
//  ARK-Project
//
//  Created by Liana Norman on 12/18/19.
//  Copyright © 2019 Liana Norman. All rights reserved.
//

import UIKit

class TakeActionVC: UIViewController {

    // MARK: - UI Objects
    lazy var headerImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "phone")
        return img
    }()
    
    lazy var state: UILabel = {
        var congressState = UILabel()
        congressState.text = ""
        congressState.textAlignment = .center
        congressState.textColor = .white
        congressState.font = UIFont(name: "Optima-ExtraBlack", size: 25)
        return congressState
    }()
    
    lazy var nameLabel: UILabel = {
        var name = UILabel()
        name.text = ""
        name.textAlignment = .center
        name.textColor = .white
        name.font = UIFont(name: "Optima-ExtraBlack", size: 22)
        name.numberOfLines = 0
        name.lineBreakMode = .byWordWrapping
        return name
    }()
    
    lazy var callButton: UIButton = {
        var b = UIButton()
        b.backgroundColor = .black
        b.setTitle("CALL NOW!!", for: .normal)
        b.titleLabel?.font = UIFont(name: "Optima-ExtraBlack", size: 22)
        b.addTarget(self, action:#selector(callButtonClicked), for: .touchUpInside)
        b.isEnabled = true
        return b
        
    }()
    
    // MARK: - Properties
    var searchParam = "NY"
    var congressData = [Member]() {
        
        didSet {
            guard congressData.count > 0 else { return }
            state.text = "State: \(congressData[0].state ?? "State not found")"
            nameLabel.text = "Congress Person:\n \(congressData[0].firstName ?? "Firstname not found") \(congressData[0].lastName ?? "Lastname not found")"
            
        }
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(headerImage)
        view.addSubview(nameLabel)
        view.addSubview(state)
        view.addSubview(callButton)
        constrainHeaderImage()
        constrainNameLabel()
        constrainStateLabel()
        constrainCallButton()
        view.backgroundColor = .black
        loadData(filterSearch: searchParam)
    }
    
    // MARK: - Actions
    @objc func callButtonClicked(sender: UIButton!) {
        dialNumber(number: "8622510086")
    }
    
    func dialNumber(number : String) {

     if let url = URL(string: "tel://\(number)"),
       UIApplication.shared.canOpenURL(url) {
          if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler:nil)
           } else {
               UIApplication.shared.openURL(url)
           }
       } else {
                // add error message here
       }
    }
    
    // MARK: - Private Methods
    func loadData(filterSearch: String) {
        LegislatorsAPIClient.shared.getMembersInfo { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let members):
                    self.congressData = members.filter({ (member) -> Bool in
                        return member.state! == filterSearch
                    })
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    // MARK: - Constraint Methods
    private func constrainHeaderImage() {
        headerImage.translatesAutoresizingMaskIntoConstraints = false
        
        [headerImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), headerImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.20), headerImage.heightAnchor.constraint(equalTo: headerImage.widthAnchor), headerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [nameLabel.topAnchor.constraint(equalTo: headerImage.bottomAnchor,constant: 30), nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor), nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor), nameLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.17)].forEach({$0.isActive = true})
    }
    
    private func constrainStateLabel() {
        state.translatesAutoresizingMaskIntoConstraints = false
        
        [state.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30), state.leadingAnchor.constraint(equalTo: view.leadingAnchor), state.trailingAnchor.constraint(equalTo: view.trailingAnchor), state.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.17)].forEach({$0.isActive = true})
    }
    
    private func constrainCallButton() {
        callButton.translatesAutoresizingMaskIntoConstraints = false
        
        [callButton.centerXAnchor.constraint(equalTo: view.centerXAnchor), callButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45), callButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1), callButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35)].forEach({$0.isActive = true})
    }
    
}
