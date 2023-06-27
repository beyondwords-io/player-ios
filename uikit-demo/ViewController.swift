import UIKit
import WebKit

class ViewController: UIViewController {
    private weak var playerView: PlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let playerView = PlayerView()
        playerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerView)
        playerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        playerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        playerView.load(PlayerSettings(projectId: 19713, contentId: "52a12d13-3ed0-48b0-9f82-12177d4a8ca1"))
        self.playerView = playerView
    }
}
