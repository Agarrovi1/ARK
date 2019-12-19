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
    lazy var touchView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
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
        b.titleLabel?.font = UIFont(name: "Optima-ExtraBlack", size: 18)
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
        constrainTouchView()
        constrainContainerView()
        containerView.addSubview(headerImage)
        containerView.addSubview(nameLabel)
        containerView.addSubview(state)
        containerView.addSubview(callButton)
        
        constrainHeaderImage()
        constrainNameLabel()
        constrainStateLabel()
        constrainCallButton()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        loadData(filterSearch: searchParam)
    }
    
    // MARK: - Actions
    @objc func callButtonClicked(sender: UIButton!) {
        if let number = congressData[0].phone {
        dialNumber(number: number)
        }
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
    private func constrainTouchView() {
        view.addSubview(touchView)
        NSLayoutConstraint.activate([
            touchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            touchView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            touchView.heightAnchor.constraint(equalToConstant: 5),
            touchView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2)
        ])
    }
    private func constrainContainerView() {
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: touchView.bottomAnchor, constant: 10),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    private func constrainHeaderImage() {
        headerImage.translatesAutoresizingMaskIntoConstraints = false
        
        [headerImage.topAnchor.constraint(equalTo: containerView.topAnchor), headerImage.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.20), headerImage.heightAnchor.constraint(equalTo: headerImage.widthAnchor), headerImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [nameLabel.topAnchor.constraint(equalTo: headerImage.bottomAnchor,constant: 30), nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor), nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor), nameLabel.heightAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.heightAnchor, multiplier: 0.17)].forEach({$0.isActive = true})
    }
    
    private func constrainStateLabel() {
        state.translatesAutoresizingMaskIntoConstraints = false
        
        [state.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30), state.leadingAnchor.constraint(equalTo: containerView.leadingAnchor), state.trailingAnchor.constraint(equalTo: containerView.trailingAnchor), state.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.17)].forEach({$0.isActive = true})
    }
    
    private func constrainCallButton() {
        callButton.translatesAutoresizingMaskIntoConstraints = false
        
        [callButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor), callButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.45), callButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.1), callButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -35)].forEach({$0.isActive = true})
    }
    
    
}
