//
//  ViewController.swift
//  Example
//
//  Created by Nikola Hristov on 6.07.23.
//

import UIKit
import BeyondWordsPlayer

class ViewController: UIViewController {
    
    private weak var projectIdField: UITextField!
    private weak var contentIdField: UITextField!
    private weak var sourceIdField: UITextField!
    private weak var playlistIdField: UITextField!
    private weak var customUICheckbox: UISwitch!
    private weak var playerViewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settingsView = UIStackView()
        settingsView.axis = .vertical
        settingsView.spacing = 16
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsView)
        settingsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        settingsView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        settingsView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        let projectIdContainer = UIStackView()
        projectIdContainer.axis = .horizontal
        projectIdContainer.distribution = .fill
        projectIdContainer.spacing = 8
        projectIdContainer.translatesAutoresizingMaskIntoConstraints = false
        let projectIdLabel = UILabel()
        projectIdLabel.text = "Project id:"
        projectIdLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        projectIdLabel.translatesAutoresizingMaskIntoConstraints = false
        projectIdContainer.addArrangedSubview(projectIdLabel)
        let projectIdField = UITextField()
        projectIdField.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        projectIdField.placeholder = "Enter project id"
        projectIdField.translatesAutoresizingMaskIntoConstraints = false
        projectIdContainer.addArrangedSubview(projectIdField)
        settingsView.addArrangedSubview(projectIdContainer)
        
        let contentIdContainer = UIStackView()
        contentIdContainer.axis = .horizontal
        contentIdContainer.distribution = .fill
        contentIdContainer.spacing = 8
        contentIdContainer.translatesAutoresizingMaskIntoConstraints = false
        let contentIdLabel = UILabel()
        contentIdLabel.text = "Content id:"
        contentIdLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        contentIdLabel.translatesAutoresizingMaskIntoConstraints = false
        contentIdContainer.addArrangedSubview(contentIdLabel)
        let contentIdField = UITextField()
        contentIdField.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        contentIdField.placeholder = "Enter content id"
        contentIdField.translatesAutoresizingMaskIntoConstraints = false
        contentIdContainer.addArrangedSubview(contentIdField)
        settingsView.addArrangedSubview(contentIdContainer)
        
        let sourceIdContainer = UIStackView()
        sourceIdContainer.axis = .horizontal
        sourceIdContainer.distribution = .fill
        sourceIdContainer.spacing = 8
        sourceIdContainer.translatesAutoresizingMaskIntoConstraints = false
        let sourceIdLabel = UILabel()
        sourceIdLabel.text = "Source id:"
        sourceIdLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        sourceIdLabel.translatesAutoresizingMaskIntoConstraints = false
        sourceIdContainer.addArrangedSubview(sourceIdLabel)
        let sourceIdField = UITextField()
        sourceIdField.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        sourceIdField.placeholder = "Enter source id"
        sourceIdField.translatesAutoresizingMaskIntoConstraints = false
        sourceIdContainer.addArrangedSubview(sourceIdField)
        settingsView.addArrangedSubview(sourceIdContainer)
        
        let playlistIdContainer = UIStackView()
        playlistIdContainer.axis = .horizontal
        playlistIdContainer.distribution = .fill
        playlistIdContainer.spacing = 8
        playlistIdContainer.translatesAutoresizingMaskIntoConstraints = false
        let playlistIdLabel = UILabel()
        playlistIdLabel.text = "Playlist id:"
        playlistIdLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        playlistIdLabel.translatesAutoresizingMaskIntoConstraints = false
        playlistIdContainer.addArrangedSubview(playlistIdLabel)
        let playlistIdField = UITextField()
        playlistIdField.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        playlistIdField.placeholder = "Enter playlist id"
        playlistIdField.translatesAutoresizingMaskIntoConstraints = false
        playlistIdContainer.addArrangedSubview(playlistIdField)
        settingsView.addArrangedSubview(playlistIdContainer)
        
        let customUIContainer = UIStackView()
        customUIContainer.axis = .horizontal
        customUIContainer.distribution = .fill
        customUIContainer.spacing = 8
        customUIContainer.translatesAutoresizingMaskIntoConstraints = false
        let customUILabel = UILabel()
        customUILabel.text = "Custom UI:"
        customUILabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        customUILabel.translatesAutoresizingMaskIntoConstraints = false
        customUIContainer.addArrangedSubview(customUILabel)
        let customUICheckbox = UISwitch()
        customUICheckbox.translatesAutoresizingMaskIntoConstraints = false
        customUIContainer.addArrangedSubview(customUICheckbox)
        settingsView.addArrangedSubview(customUIContainer)
        
        let loadButton = UIButton(type: .system)
        loadButton.setTitle("Load", for: .normal)
        loadButton.setTitleColor(.black, for: .normal)
        loadButton.translatesAutoresizingMaskIntoConstraints = false
        settingsView.addArrangedSubview(loadButton)
        
        let playerViewContainer = UIView()
        playerViewContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerViewContainer)
        playerViewContainer.topAnchor.constraint(equalTo: settingsView.bottomAnchor).isActive = true
        playerViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        playerViewContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        playerViewContainer.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        projectIdField.text = UserDefaults.standard.string(forKey: "projectId")
        contentIdField.text = UserDefaults.standard.string(forKey: "contentId")
        playlistIdField.text = UserDefaults.standard.string(forKey: "playlistId")
        sourceIdField.text = UserDefaults.standard.string(forKey: "sourceId")
        customUICheckbox.setOn(UserDefaults.standard.bool(forKey: "customUI"), animated: false)
        
        self.projectIdField = projectIdField
        self.contentIdField = contentIdField
        self.playlistIdField = playlistIdField
        self.sourceIdField = sourceIdField
        self.customUICheckbox = customUICheckbox
        self.playerViewContainer = playerViewContainer
        
        loadButton.addTarget(self, action: #selector(load), for: .touchUpInside)
    }
    
    @objc func load() {
        UserDefaults.standard.setValue(projectIdField.text, forKey: "projectId")
        UserDefaults.standard.setValue(contentIdField.text, forKey: "contentId")
        UserDefaults.standard.setValue(playlistIdField.text, forKey: "playlistId")
        UserDefaults.standard.setValue(sourceIdField.text, forKey: "sourceId")
        UserDefaults.standard.setValue(customUICheckbox.isOn, forKey: "customUI")
        let playerSettings = PlayerSettings(
            projectId: Int(projectIdField.text ?? ""),
            contentId: contentIdField.text,
            playlistId: Int(playlistIdField.text ?? ""),
            sourceId: sourceIdField.text
        )
        
        let playerView: UIView
        switch customUICheckbox.isOn {
        case true:
            let customPlayerView = CustomPlayerView()
            customPlayerView.verbose = true
            customPlayerView.load(playerSettings)
            playerView = customPlayerView
        case false:
            let defaultPlayerView = PlayerView()
            defaultPlayerView.verbose = true
            defaultPlayerView.load(playerSettings)
            playerView = defaultPlayerView
        }
        
        for view in playerViewContainer.subviews {
            view.removeFromSuperview()
        }
        
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerViewContainer.addSubview(playerView)
        playerView.topAnchor.constraint(equalTo: playerViewContainer.topAnchor).isActive = true
        playerView.widthAnchor.constraint(equalTo: playerViewContainer.widthAnchor).isActive = true
    }
}
