//
//  InitialVC.swift
//  ARK-Project
//
//  Created by Liana Norman on 12/18/19.
//  Copyright © 2019 Liana Norman. All rights reserved.
//

import UIKit
import AVKit

class InitialVC: UIViewController {
    
    // MARK: - UI Objects
    lazy var appNamelabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Optima-ExtraBlack", size: 65)
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .black
        label.text = "ARK"
        return label
    }()
    
    lazy var tapButton: UIButton = {
        
        var b = UIButton()
        
        b.setTitle("", for: .normal)
        b.addTarget(self, action:#selector(tapButtonClicked), for: .touchUpInside)
        b.isEnabled = true
        return b
        
    }()
    
    @objc func tapButtonClicked(sender: UIButton!) {
       guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate
           else {
               return
       }
        UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromBottom, animations: {
            sceneDelegate.window?.rootViewController = MapVC()
        }, completion: nil)
    }
    // MARK: - Properties
    var videoPlayer: AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?
    
    //MARK: -- Lifecylce Methods
    override func viewDidLoad() {
      super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
      //set uo video in the background
      setUpVideo()
      loopPlayer()
      setUpElements()
    constrainLabel()
        constrainButton()
    }
    
    //MARK: -- Private Functions
    private func setUpElements() {
        view.addSubview(appNamelabel)
        view.addSubview(tapButton)
    }
    
    private func setUpVideo() {
      
      //Get the path to the resource in the bundle
      let bundlePath = Bundle.main.path(forResource: "noahsVideo", ofType: "mp4")
      
      guard bundlePath != nil else {return}
      
      //Create an URL for it
      let url = URL(fileURLWithPath: bundlePath!)
      
      //Create the video player item
      let item = AVPlayerItem(url: url)
      
      //Create the player
      videoPlayer = AVPlayer(playerItem: item)
      
      //Create the layer
      videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
      
      //Adjust the size and frame
      videoPlayerLayer?.frame = CGRect(x:
        -view.frame.size.width * 1.6, y: 0, width:
      view.frame.size.width * 4.2, height:
      view.frame.size.height)
      
      view.layer.insertSublayer(videoPlayerLayer!, at: 0)
      
      //add it and play it
        videoPlayer?.playImmediately(atRate: 0.3)
    }
    
    func loopPlayer() {
      NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.videoPlayer?.currentItem, queue: .main) { [weak self] _ in
        self?.videoPlayer?.seek(to: CMTime.zero)
        self?.videoPlayer?.playImmediately(atRate: 0.3)
      }
    }
    
    // MARK: - Constraint Methods
    private func constrainLabel() {
        appNamelabel.translatesAutoresizingMaskIntoConstraints = false
        
        [appNamelabel.centerYAnchor.constraint(equalTo: view.centerYAnchor), appNamelabel.leadingAnchor.constraint(equalTo: view.leadingAnchor), appNamelabel.trailingAnchor.constraint(equalTo: view.trailingAnchor), appNamelabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.15)].forEach({$0.isActive = true})
    }
    
    private func constrainButton() {
        tapButton.translatesAutoresizingMaskIntoConstraints = false
        
        [tapButton.topAnchor.constraint(equalTo: view.topAnchor), tapButton.leadingAnchor.constraint(equalTo: view.leadingAnchor), tapButton.trailingAnchor.constraint(equalTo: view.trailingAnchor), tapButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)].forEach({$0.isActive = true})
    }
    
    
    

}
