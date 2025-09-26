//
//  PlaybackFromSegmentsViewController.swift
//  Example
//
//  Created by Nikola Hristov on 25.09.25.
//

import UIKit
import BeyondWordsPlayer

class PlaybackFromSegmentsViewController: UIViewController {

    private weak var playerView: PlayerView!
    private weak var firstSegmentLabel: UILabel!
    private weak var secondSegmentLabel: UILabel!
    private weak var thirdSegmentLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

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

        let titleLabel = UILabel()
        titleLabel.text = "Will quantum computers disrupt critical infrastructure?"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(titleLabel)

        let playerViewContainer = UIStackView()
        playerViewContainer.distribution = .fill
        playerViewContainer.axis = .vertical
        playerViewContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addArrangedSubview(playerViewContainer)
        let playerView = PlayerView()
        playerView.delegate = self
        playerView.load(PlayerSettings(
            projectId: 48772,
            contentId: "2a1038c4-dafe-40aa-9b9a-442a537794f2",
            summary: true
        ))
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerViewContainer.addArrangedSubview(playerView)
        self.playerView = playerView

        let firstSegmentLabel = UILabel()
        firstSegmentLabel.text = "Twenty-five years ago, concerns over the millennium bug led to fears of widespread digital failures, but the actual impact was minimal; today, however, a new threat looms with the rise of quantum computing, which could easily crack existing encryption algorithms."
        firstSegmentLabel.font = .systemFont(ofSize: 18)
        firstSegmentLabel.numberOfLines = 0
        firstSegmentLabel.translatesAutoresizingMaskIntoConstraints = false
        firstSegmentLabel.isUserInteractionEnabled = true
        firstSegmentLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(segmentTapped(_:))))
        contentView.addArrangedSubview(firstSegmentLabel)
        self.firstSegmentLabel = firstSegmentLabel

        let secondSegmentLabel = UILabel()
        secondSegmentLabel.text = "Quantum computers operate using qubits, allowing them to perform complex calculations much faster than classical computers, potentially compromising the security of sensitive data across various sectors, including finance and personal information."
        secondSegmentLabel.font = .systemFont(ofSize: 18)
        secondSegmentLabel.numberOfLines = 0
        secondSegmentLabel.translatesAutoresizingMaskIntoConstraints = false
        secondSegmentLabel.isUserInteractionEnabled = true
        secondSegmentLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(segmentTapped(_:))))
        contentView.addArrangedSubview(secondSegmentLabel)
        self.secondSegmentLabel = secondSegmentLabel

        let thirdSegmentLabel = UILabel()
        thirdSegmentLabel.text = "While quantum computers capable of breaking current encryption are still years away, the technology industry is proactively developing post-quantum encryption standards to secure digital information, emphasizing the need for a comprehensive upgrade of existing systems to mitigate future risks."
        thirdSegmentLabel.font = .systemFont(ofSize: 18)
        thirdSegmentLabel.numberOfLines = 0
        thirdSegmentLabel.translatesAutoresizingMaskIntoConstraints = false
        thirdSegmentLabel.isUserInteractionEnabled = true
        thirdSegmentLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(segmentTapped(_:))))
        contentView.addArrangedSubview(thirdSegmentLabel)
        self.thirdSegmentLabel = thirdSegmentLabel
    }
    
    @objc private func segmentTapped(_ gesture: UITapGestureRecognizer) {
        if (gesture.view === self.firstSegmentLabel) {
            playerView.setCurrentSegment(segmentMarker: "ce3811c3-46e0-4007-88ae-231e2a019564")
        } else if (gesture.view === self.secondSegmentLabel) {
            playerView.setCurrentSegment(segmentMarker: "ed331186-cd55-41c3-a524-96789ad99b39")
        } else if (gesture.view === self.thirdSegmentLabel) {
            playerView.setCurrentSegment(segmentMarker: "693e0c4e-ca13-4274-8dd0-c957950a91cf")
        }
    }
}

extension PlaybackFromSegmentsViewController : PlayerDelegate {
    public func player(_ playerView: PlayerView, onEvent event: PlayerEvent, settings: PlayerSettings) {
        if (self.playerView !== playerView) { return }
        
        if (event.type == "CurrentSegmentUpdated") {
            self.firstSegmentLabel.backgroundColor = .clear;
            self.secondSegmentLabel.backgroundColor = .clear;
            self.thirdSegmentLabel.backgroundColor = .clear;
            if (settings.currentSegment?.marker == "ce3811c3-46e0-4007-88ae-231e2a019564") {
                self.firstSegmentLabel.backgroundColor = .lightGray
            } else if (settings.currentSegment?.marker == "ed331186-cd55-41c3-a524-96789ad99b39") {
                self.secondSegmentLabel.backgroundColor = .lightGray
            } else if (settings.currentSegment?.marker == "693e0c4e-ca13-4274-8dd0-c957950a91cf") {
                self.thirdSegmentLabel.backgroundColor = .lightGray
            }
        }
    }
}
