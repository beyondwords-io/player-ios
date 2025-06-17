//
//  CustomPlayerView.swift
//  Example
//
//  Created by Nikola Hristov on 7.07.23.
//

import UIKit
import BeyondWordsPlayer

public class CustomPlayerView: UIStackView {
    
    public var autoplay = false
    
    public var verbose = false {
        didSet {
            playerView.verbose = verbose
        }
    }
    
    private lazy var playerView = {
        let playerView = PlayerView()
        playerView.delegate = self
        return playerView
    }()
    
    private lazy var errorView = {
        let errorView = UILabel()
        errorView.numberOfLines = 5
        errorView.font = errorView.font.withSize(18)
        errorView.textColor = UIColor.red
        return errorView
    }()
    
    private lazy var spinnerView = {
        let spinnerView = UIActivityIndicatorView(style: .large)
        return spinnerView;
    }()
    
    private lazy var controlBar = {
        let controlBar = UIStackView()
        controlBar.distribution = .fill
        controlBar.axis = .vertical
        controlBar.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        return controlBar
    }()
    
    private lazy var playButton = {
        let playButton = UIButton()
        playButton.setImage(UIImage(systemName: "play"), for: .normal)
        playButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        return playButton
    }()
    
    private lazy var pauseButton = {
        let pauseButton = UIButton()
        pauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
        pauseButton.addTarget(self, action: #selector(pause), for: .touchUpInside)
        return pauseButton
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
        setupUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        distribution = .fill
        axis = .vertical
        
        playerView.translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(playerView)
        
        spinnerView.isHidden = false;
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(spinnerView)
        spinnerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        spinnerView.startAnimating()
        
        errorView.isHidden = true
        errorView.translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(errorView)
        
        controlBar.isHidden = true
        controlBar.translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(controlBar)
        controlBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        playButton.isHidden = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        controlBar.addArrangedSubview(playButton)
        playButton.topAnchor.constraint(equalTo: controlBar.topAnchor).isActive = true
        playButton.leftAnchor.constraint(equalTo: controlBar.leftAnchor).isActive = true
        playButton.bottomAnchor.constraint(equalTo: controlBar.bottomAnchor).isActive = true
        playButton.widthAnchor.constraint(equalTo: controlBar.heightAnchor).isActive = true
        
        pauseButton.isHidden = true
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        controlBar.addArrangedSubview(pauseButton)
        pauseButton.topAnchor.constraint(equalTo: controlBar.topAnchor).isActive = true
        pauseButton.leftAnchor.constraint(equalTo: controlBar.leftAnchor).isActive = true
        pauseButton.bottomAnchor.constraint(equalTo: controlBar.bottomAnchor).isActive = true
        pauseButton.widthAnchor.constraint(equalTo: controlBar.heightAnchor).isActive = true
        
        contentTitleView.translatesAutoresizingMaskIntoConstraints = false
        controlBar.addArrangedSubview(contentTitleView)
        contentTitleView.topAnchor.constraint(equalTo: controlBar.topAnchor).isActive = true
        contentTitleView.rightAnchor.constraint(equalTo: controlBar.rightAnchor).isActive = true
        contentTitleView.leftAnchor.constraint(equalTo: controlBar.leftAnchor, constant: 60).isActive = true
        contentTitleView.heightAnchor.constraint(equalTo: controlBar.heightAnchor, multiplier: 0.5).isActive = true
        
        playerTitleView.translatesAutoresizingMaskIntoConstraints = false
        controlBar.addArrangedSubview(playerTitleView)
        playerTitleView.bottomAnchor.constraint(equalTo: controlBar.bottomAnchor).isActive = true
        playerTitleView.rightAnchor.constraint(equalTo: controlBar.rightAnchor).isActive = true
        playerTitleView.leftAnchor.constraint(equalTo: controlBar.leftAnchor, constant: 60).isActive = true
        playerTitleView.heightAnchor.constraint(equalTo: controlBar.heightAnchor, multiplier: 0.5).isActive = true
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
        
        switch settings.playbackState {
        case "playing":
            playButton.isHidden = true
            pauseButton.isHidden = false
        default:
            playButton.isHidden = false
            pauseButton.isHidden = true
        }
        
        if (event.type == "MetadataLoaded") {
            spinnerView.isHidden = true
            spinnerView.stopAnimating()
            errorView.isHidden = true
            controlBar.isHidden = false
            if (autoplay) {
                playerView.setPlaybackState("playing")
            }
        }
        
        if (event.type == "NoContentAvailable" || event.type == "PlaybackErrored") {
            spinnerView.isHidden = true
            spinnerView.stopAnimating()
            errorView.isHidden = false
            errorView.text = event.description
            controlBar.isHidden = true
        }
    }
    
    @objc private func pause() {
        playerView.setPlaybackState("paused")
    }
    
    @objc private func play() {
        playerView.setPlaybackState("playing")
    }
}
