//
//  MainViewController.swift
//  Example
//
//  Created by Nikola Hristov on 6.07.23.
//

import UIKit
import BeyondWordsPlayer
import JVFloatLabeledText

class MainViewController: UIViewController {
    
    private weak var projectIdInput: UITextView!
    private weak var contentIdInput: UITextView!
    private weak var sourceIdInput: UITextView!
    private weak var playlistIdInput: UITextView!
    private weak var playerStyleInput: UITextView!
    private weak var playerUIInput: UITextView!
    private weak var playerViewContainer: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        let contentView = UIStackView()
        contentView.distribution = .fill
        contentView.spacing = 16
        contentView.axis = .vertical
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
        let heightContraint = contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        heightContraint.priority = .defaultLow
        heightContraint.isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        
        self.projectIdInput = createTextInputField(name: "projectId", placeholder: "Project id", parent: contentView)
        self.contentIdInput = createTextInputField(name: "contentId", placeholder: "Content id:", parent: contentView)
        self.sourceIdInput = createTextInputField(name: "sourceId", placeholder: "Source id:", parent: contentView)
        self.playlistIdInput = createTextInputField(name: "playlistId", placeholder: "Playlist id:", parent: contentView)
        self.playerStyleInput = createSelectInputField(name: "playerStyle", placeholder: "Player style:", action: #selector(selectPlayerStyle), parent: contentView)
        self.playerUIInput = createSelectInputField(name: "playerUI", placeholder: "Player UI:", action: #selector(selectPlayerUI), parent: contentView)
        
        let button = UIButton(type: .system)
        button.setTitle("Load Player", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(button)
        button.addTarget(self, action: #selector(load), for: .touchUpInside)

        let playerViewContainer = UIStackView()
        playerViewContainer.distribution = .fill
        playerViewContainer.axis = .vertical
        playerViewContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(playerViewContainer)
        self.playerViewContainer = playerViewContainer
    }
    
    func createSelectInputField(name: String, placeholder: String, action: Selector, parent: UIStackView) -> UITextView {
        let inputField = createTextInputField(name: name, placeholder: placeholder, parent: parent)
        inputField.isEditable = false
        inputField.isSelectable = false
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: action)
        tapRecognizer.numberOfTapsRequired = 1
        inputField.addGestureRecognizer(tapRecognizer)
        
        return inputField
    }
    
    func createTextInputField(name: String, placeholder: String, parent: UIStackView) -> UITextView {
        let inputContainer = UIView()
        inputContainer.translatesAutoresizingMaskIntoConstraints = false
        parent.addArrangedSubview(inputContainer)
        inputContainer.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        let inputField = JVFloatLabeledTextView()
        inputField.text = UserDefaults.standard.string(forKey: name)
        inputField.placeholder = "  " + placeholder
        inputField.isScrollEnabled = false
        inputField.sizeToFit()
        inputField.autocorrectionType = .no
        inputField.spellCheckingType = .no
        inputField.textContainerInset = .init(top: 0, left: 6, bottom: 0, right: 6)
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputContainer.addSubview(inputField)
        inputField.topAnchor.constraint(equalTo: inputContainer.topAnchor).isActive = true
        inputField.bottomAnchor.constraint(equalTo: inputContainer.bottomAnchor).isActive = true
        inputField.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
        inputField.rightAnchor.constraint(equalTo: inputContainer.rightAnchor).isActive = true
        
        let borderBottom = UIView()
        borderBottom.backgroundColor = .lightGray
        borderBottom.translatesAutoresizingMaskIntoConstraints = false
        inputContainer.addSubview(borderBottom)
        borderBottom.heightAnchor.constraint(equalToConstant: 1).isActive = true
        borderBottom.bottomAnchor.constraint(equalTo: inputContainer.bottomAnchor).isActive = true
        borderBottom.leftAnchor.constraint(equalTo: inputContainer.leftAnchor).isActive = true
        borderBottom.rightAnchor.constraint(equalTo: inputContainer.rightAnchor).isActive = true
        
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
            // Uncomment to enable autoplay
            // customPlayerView.autoplay = true
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
        playerViewContainer.addArrangedSubview(playerView)
    }
}
