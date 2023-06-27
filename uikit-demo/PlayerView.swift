import UIKit
import WebKit

fileprivate struct BridgeMessage: Codable {
    var type: String
    var event: PlayerEvent? = nil
    var settings: PlayerSettings? = nil
}

fileprivate class WeakWKScriptMessageHandler : NSObject, WKScriptMessageHandler {
    weak var delegate : WKScriptMessageHandler?
    
    init(delegate: WKScriptMessageHandler) {
        self.delegate = delegate
        super.init()
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        self.delegate?.userContentController(userContentController, didReceive: message)
    }
}

class PlayerView: UIView, WKNavigationDelegate, WKScriptMessageHandler {
    private lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = .all
        let contentController = WKUserContentController()
        contentController.add(WeakWKScriptMessageHandler(delegate: self), name: "iOSBridge")
        configuration.userContentController = contentController
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = self
        webView.scrollView.bounces = false
        webView.scrollView.isScrollEnabled = false
#if DEBUG
        webView.isInspectable = true
#endif
        guard let playerHTMLPath = Bundle.main.path(forResource: "player", ofType: "html") else {
            fatalError("player.html not found!")
        }
        guard let playerHTMLPage = try? String(contentsOfFile: playerHTMLPath) else {
            fatalError("player.html could not be loaded!")
        }
        let baseURL = URL(string: "https://beyondwords.io")
        webView.loadHTMLString(playerHTMLPage, baseURL: baseURL)
        return webView;
    }()
    
    private let jsonDecoded = JSONDecoder()
    
    private let jsonEncoder = JSONEncoder()
    
    private var pendingCommands: [String] = []
    
    private var ready = false
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name != "iOSBridge" {
            return
        }
        
        guard let messageString = message.body as? String,
              let messageData = messageString.data(using: .utf8),
              let decodedMessage = try? jsonDecoded.decode(BridgeMessage.self, from: messageData) else {
            fatalError("Cannot decode iOSBridge message: \(message.body)")
        }
        
        switch (decodedMessage.type) {
        case "ready":
            onReady()
        case "event":
            onEvent(event: decodedMessage.event!, settings: decodedMessage.settings!)
        default:
            print("Unknown message received from iOSBridge \(decodedMessage.type)")
        }
    }
    
    public func load(_ playerSettings: PlayerSettings) {
        callFunction("load", args: [playerSettings])
    }
    
    private func commonInit() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(webView)
        webView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        webView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        webView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        webView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        webView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
    }
    
    private func onReady() {
        ready = true
        pendingCommands.forEach { exec($0) }
        pendingCommands.removeAll()
    }
    
    private func onResize() {
        // TODO
    }
    
    private func onEvent(event: PlayerEvent, settings: PlayerSettings) {
        print("HII \(event) \(settings)")
    }
    
    private func setProp(_ name: String, value: Encodable) {
        // TODO
    }
    
    private func callFunction(_ name: String, args: Array<Encodable>) {
        exec(String(
            format: "%@(%@)",
            name,
            args.compactMap { try? jsonEncoder.encode($0) }
                .compactMap { String(data: $0, encoding: .utf8) }
                .joined(separator: ",")
        ))
    }
    
    private func exec(_ command: String) {
        if (!ready) {
            pendingCommands.append(command)
        } else {
            webView.evaluateJavaScript(command, completionHandler: nil)
        }
    }
}
