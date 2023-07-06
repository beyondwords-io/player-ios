//
//  ViewController.swift
//  Example
//
//  Created by Nikola Hristov on 6.07.23.
//

import UIKit
import BeyondWordsPlayer

class ViewController: UIViewController, PlayerDelegate {
    
    private weak var playerView: PlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let playerView = PlayerView()
        playerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerView)
        playerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        playerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        playerView.delegate = self
        playerView.load(PlayerSettings(projectId: 19713, contentId: "52a12d13-3ed0-48b0-9f82-12177d4a8ca1"))
        self.playerView = playerView
    }
    
    func player(_ player: PlayerView, onEvent event: PlayerEvent, settings: PlayerSettings) {
        print("onEvent \(event) \(settings)")
    }
}
