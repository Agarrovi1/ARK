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
    }
    
    //MARK: -- Private Functions
    private func setUpElements() {
        view.addSubview(appNamelabel)
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
    

}
