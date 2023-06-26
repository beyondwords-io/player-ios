import UIKit
import WebKit

class ViewController: UIViewController {
    private lazy var playerView: PlayerView = {
        return PlayerView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerView)
        playerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        playerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
}
