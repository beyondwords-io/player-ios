//
//  CustomPlayerView.swift
//  Example
//
//  Created by Nikola Hristov on 7.07.23.
//

import UIKit
import BeyondWordsPlayer

public class CustomPlayerView: UIView {
    
    private lazy var playerView = {
        let playerView = PlayerView()
        playerView.delegate = self
        return playerView
    }()
    
    private lazy var playPauseButton = {
        let playPauseButton = UIButton()
        playPauseButton.setImage(UIImage(systemName: "play"), for: .normal)
        playPauseButton.isEnabled = false
        return playPauseButton
    }()
    
    private lazy var contentTitleView = {
        let contentTitleView = UILabel()
        contentTitleView.numberOfLines = 1
        contentTitleView.font = contentTitleView.font.withSize(18)
        return contentTitleView
    }()
    
    private lazy var playerTitleView = {
        let playerTitleView = UILabel()
        playerTitleView.numberOfLines = 1
        playerTitleView.font = playerTitleView.font.withSize(14)
        return playerTitleView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        layer.cornerRadius = 16;
        layer.masksToBounds = true;

        heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        playerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(playerView)
        playerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        playerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        playerView.widthAnchor.constraint(equalToConstant: 0).isActive = true
        playerView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(playPauseButton)
        playPauseButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        playPauseButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        playPauseButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        playPauseButton.widthAnchor.constraint(equalTo: playPauseButton.heightAnchor).isActive = true
        
        contentTitleView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentTitleView)
        contentTitleView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentTitleView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        contentTitleView.leftAnchor.constraint(equalTo: playPauseButton.rightAnchor).isActive = true
        contentTitleView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        playerTitleView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(playerTitleView)
        playerTitleView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        playerTitleView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        playerTitleView.leftAnchor.constraint(equalTo: playPauseButton.rightAnchor).isActive = true
        playerTitleView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
    }
    
    public func load(_ playerSettings: PlayerSettings) {
        var playerSettingsCopy = playerSettings
        playerSettingsCopy.showUserInterface = false
        playerView.load(playerSettingsCopy)
    }
}

extension CustomPlayerView : PlayerDelegate {
    public func player(_ playerView: PlayerView, onEvent event: PlayerEvent, settings: PlayerSettings) {
        if (self.playerView !== playerView) { return }
        
        if let content = settings.content,
           let contentIndex = settings.contentIndex,
           content.count > contentIndex {
            contentTitleView.text = content[contentIndex].title
        } else {
            contentTitleView.text = ""
        }
        
        playerTitleView.text = settings.playerTitle

        playPauseButton.isEnabled = true
        switch settings.playbackState {
        case "playing":
            playPauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
            playPauseButton.addTarget(self, action: #selector(pause), for: .touchUpInside)
        default:
            playPauseButton.setImage(UIImage(systemName: "play"), for: .normal)
            playPauseButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        }
    }
    
    @objc private func pause() {
        playerView.setPlaybackState("paused")
    }
    
    @objc private func play() {
        playerView.setPlaybackState("playing")
    }
}
