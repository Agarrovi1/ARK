//
//  ResourcesVC.swift
//  ARK-Project
//
//  Created by Liana Norman on 12/18/19.
//  Copyright © 2019 Liana Norman. All rights reserved.
//

import UIKit

class ResourcesVC: UIViewController {

    // MARK: - UI Objects
    lazy var headerImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "tornado")
        return img
    }()
    
    lazy var resourceCV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        cv.register(ResourcesCVCell.self, forCellWithReuseIdentifier: "ResourcesCVCell")
        return cv
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        constrainHeaderImage()
        constrainResourceCV()
        delegation()
        view.backgroundColor = .black
    }
    
    // MARK: - Private Methods
    private func setupVCViews() {
        view.backgroundColor = .black
    }
    
    private func addSubviews() {
        view.addSubview(headerImage)
        view.addSubview(resourceCV)
    }
    
    private func delegation() {
        resourceCV.delegate = self
        resourceCV.dataSource = self
    }
    
    // MARK: - Constraint Methods
    private func constrainHeaderImage() {
        headerImage.translatesAutoresizingMaskIntoConstraints = false
        
        [headerImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10), headerImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.20), headerImage.heightAnchor.constraint(equalTo: headerImage.widthAnchor), headerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)].forEach({$0.isActive = true})
    }
    
    private func constrainResourceCV() {
        resourceCV.translatesAutoresizingMaskIntoConstraints = false
        
        [resourceCV.topAnchor.constraint(equalTo: headerImage.bottomAnchor), resourceCV.leadingAnchor.constraint(equalTo: view.leadingAnchor), resourceCV.trailingAnchor.constraint(equalTo: view.trailingAnchor), resourceCV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)].forEach({$0.isActive = true})
    }
    


}

extension ResourcesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allResources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = resourceCV.dequeueReusableCell(withReuseIdentifier: "ResourcesCVCell", for: indexPath) as? ResourcesCVCell {
            let resource = allResources[indexPath.row]
            cell.nameLabel.text = resource.orgName
            cell.cellImageView.image = resource.image
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}

extension ResourcesVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let resource = allResources[indexPath.row]
        UIApplication.shared.open(URL(string: resource.link)!, options: [:], completionHandler: nil)
    }
}

extension ResourcesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: 125)
    }
}
