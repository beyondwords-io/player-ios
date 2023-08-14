//
//  ViewController.swift
//  Example
//
//  Created by Nikola Hristov on 6.07.23.
//

import UIKit
import BeyondWordsPlayer
import JVFloatLabeledText

class ViewController: UIViewController {
    
    private weak var projectIdInput: UITextView!
    private weak var contentIdInput: UITextView!
    private weak var sourceIdInput: UITextView!
    private weak var playlistIdInput: UITextView!
    private weak var playerStyleInput: UITextView!
    private weak var playerUIInput: UITextView!
    private weak var playerViewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let projectIdInput = createTextInputField(name: "projectId", placeholder: "Project id")
        projectIdInput.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        
        let contentIdInput = createTextInputField(name: "contentId", placeholder: "Content id:")
        contentIdInput.topAnchor.constraint(equalTo: projectIdInput.bottomAnchor, constant: 12).isActive = true
        
        let sourceIdInput = createTextInputField(name: "sourceId", placeholder: "Source id:")
        sourceIdInput.topAnchor.constraint(equalTo: contentIdInput.bottomAnchor, constant: 12).isActive = true
        
        let playlistIdInput = createTextInputField(name: "playlistId", placeholder: "Playlist id:")
        playlistIdInput.topAnchor.constraint(equalTo: sourceIdInput.bottomAnchor, constant: 12).isActive = true
        
        let playerStyleInput = createSelectInputField(name: "playerStyle", placeholder: "Player style:", action: #selector(selectPlayerStyle))
        playerStyleInput.topAnchor.constraint(equalTo: playlistIdInput.bottomAnchor, constant: 12).isActive = true
        
        let playerUIInput = createSelectInputField(name: "playerUI", placeholder: "Player UI:", action: #selector(selectPlayerUI))
        playerUIInput.topAnchor.constraint(equalTo: playerStyleInput.bottomAnchor, constant: 12).isActive = true
        
        let loadButton = createButton(title: "Load Player", action: #selector(load))
        loadButton.topAnchor.constraint(equalTo: playerUIInput.bottomAnchor, constant: 12).isActive = true
        
        let playerViewContainer = UIView()
        playerViewContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerViewContainer)
        playerViewContainer.topAnchor.constraint(equalTo: loadButton.bottomAnchor, constant: 12).isActive = true
        playerViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        playerViewContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        playerViewContainer.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        self.projectIdInput = projectIdInput
        self.contentIdInput = contentIdInput
        self.sourceIdInput = sourceIdInput
        self.playlistIdInput = playlistIdInput
        self.playerStyleInput = playerStyleInput
        self.playerUIInput = playerUIInput
        self.playerViewContainer = playerViewContainer
    }
    
    func createButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    func createSelectInputField(name: String, placeholder: String, action: Selector) -> UITextView {
        let inputField = createTextInputField(name: name, placeholder: placeholder)
        inputField.isEditable = false
        inputField.isSelectable = false
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: action)
        tapRecognizer.numberOfTapsRequired = 1
        inputField.addGestureRecognizer(tapRecognizer)
        
        return inputField
    }
    
    func createTextInputField(name: String, placeholder: String) -> UITextView {
        let inputField = JVFloatLabeledTextView()
        inputField.text = UserDefaults.standard.string(forKey: name)
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.placeholder = "  " + placeholder
        inputField.isScrollEnabled = false
        inputField.sizeToFit()
        inputField.autocorrectionType = .no
        inputField.spellCheckingType = .no
        inputField.textContainerInset = .init(top: 0, left: 6, bottom: 0, right: 6)
        view.addSubview(inputField)
        inputField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        inputField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        inputField.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        let borderBottom = UIView()
        borderBottom.backgroundColor = .lightGray
        borderBottom.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(borderBottom)
        borderBottom.heightAnchor.constraint(equalToConstant: 1).isActive = true
        borderBottom.bottomAnchor.constraint(equalTo: inputField.bottomAnchor).isActive = true
        borderBottom.leftAnchor.constraint(equalTo: inputField.leftAnchor).isActive = true
        borderBottom.rightAnchor.constraint(equalTo: inputField.rightAnchor).isActive = true
        
        return inputField
    }
    
    @objc func selectPlayerStyle() {
        let alert = UIAlertController(title: "Player style", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Small", style: .default , handler: { (UIAlertAction) in
            self.playerStyleInput.text = "small"
        }))
        alert.addAction(UIAlertAction(title: "Standard", style: .default , handler: { (UIAlertAction) in
            self.playerStyleInput.text = "standard"
        }))
        alert.addAction(UIAlertAction(title: "Large", style: .default , handler: { (UIAlertAction) in
            self.playerStyleInput.text = "large"
        }))
        alert.addAction(UIAlertAction(title: "Video", style: .default , handler: { (UIAlertAction) in
            self.playerStyleInput.text = "video"
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @objc func selectPlayerUI() {
        let alert = UIAlertController(title: "Player UI", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Default", style: .default , handler: { (UIAlertAction) in
            self.playerUIInput.text = "default"
        }))
        alert.addAction(UIAlertAction(title: "Custom", style: .default , handler: { (UIAlertAction) in
            self.playerUIInput.text = "custom"
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func load() {
        UserDefaults.standard.setValue(projectIdInput.text, forKey: "projectId")
        UserDefaults.standard.setValue(contentIdInput.text, forKey: "contentId")
        UserDefaults.standard.setValue(sourceIdInput.text, forKey: "sourceId")
        UserDefaults.standard.setValue(playlistIdInput.text, forKey: "playlistId")
        UserDefaults.standard.setValue(playerStyleInput.text, forKey: "playerStyle")
        UserDefaults.standard.setValue(playerUIInput.text, forKey: "playerUI")

        let playerSettings = PlayerSettings(
            projectId: !projectIdInput.text.isEmpty ? Int(projectIdInput.text) : nil,
            contentId: !contentIdInput.text.isEmpty ? contentIdInput.text : nil,
            playlistId: !playlistIdInput.text.isEmpty ? Int(playlistIdInput.text) : nil,
            sourceId: !sourceIdInput.text.isEmpty ? sourceIdInput.text : nil,
            playerStyle: !playerStyleInput.text.isEmpty ? playerStyleInput.text : nil
        )
        
        let playerView: UIView
        switch playerUIInput.text {
        case "custom":
            let customPlayerView = CustomPlayerView()
            customPlayerView.verbose = true
            customPlayerView.load(playerSettings)
            playerView = customPlayerView
        default:
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
