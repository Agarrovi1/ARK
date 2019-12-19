//
//  TakeActionVC.swift
//  ARK-Project
//
//  Created by Liana Norman on 12/18/19.
//  Copyright © 2019 Liana Norman. All rights reserved.
//

import UIKit

class TakeActionVC: UIViewController {

    var searchParam = ""
    
    var congressData = [Member]() {
        
        didSet {
            guard congressData.count > 0 else { return }
            state.text = "State: \(congressData[0].state ?? "State not found")"
            nameLabel.text = "Congress Person:\n \(congressData[0].firstName ?? "Firstname not found") \(congressData[0].lastName ?? "Lastname not found")"
            
        }
    }
    
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

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let topImage = UIImageView()
        topImage.frame = CGRect (x: 150, y: 50, width: 100, height: 100)
        topImage.image = UIImage(systemName: "phone")
        view.addSubview(topImage)
        
        view.addSubview(nameLabel)
        view.addSubview(state)
        view.addSubview(callButton)
        
        view.backgroundColor = .black
        
        loadData(filterSearch: searchParam)
    }
    
    lazy var state: UILabel = {
        var congressState = UILabel()
        congressState.frame = CGRect (x: 70, y: 200, width: 300, height: 50)
        congressState.text = ""
        congressState.textAlignment = .center
        congressState.textColor = .white
        congressState.font = UIFont(name: "Optima-ExtraBlack", size: 40)
        return congressState
    }()
    
    lazy var nameLabel: UILabel = {
        var name = UILabel()
        name.frame = CGRect (x: 65, y: 300, width: 300, height: 50)
        name.text = ""
        name.textAlignment = .center
        name.textColor = .white
        name.font = UIFont(name: "Optima-ExtraBlack", size: 20)
        name.numberOfLines = 0
        name.lineBreakMode = .byWordWrapping
        return name
    }()
    
    lazy var callButton: UIButton = {
        
        var b = UIButton()
        b.frame = CGRect (x: 150, y: 400, width: 200, height: 200)
        b.backgroundColor = .black
        b.setTitle("CALL NOW", for: .normal)
        b.addTarget(self, action:#selector(callButtonClicked), for: .touchUpInside)
        b.isEnabled = true
        return b
        
    }()
    
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
    
}
