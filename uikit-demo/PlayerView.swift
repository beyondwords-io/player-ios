import UIKit
import WebKit

fileprivate struct BridgeMessage: Codable {
    var type: String
    var event: PlayerEvent? = nil
    var settings: PlayerSettings? = nil
    var width: Int? = nil
    var height: Int? = nil
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
    private lazy var webViewContainer = {
        UIView()
    }()
    private lazy var webView = {
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
    
    private lazy var webViewContainerHeightConstraint = {
        let heightConstraint = webViewContainer.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint.isActive = true
        return heightConstraint
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
        case "resize":
            onResize(width: decodedMessage.width!, height: decodedMessage.height!)
        case "event":
            onEvent(event: decodedMessage.event!, settings: decodedMessage.settings!)
        default:
            print("Unknown message received from iOSBridge \(decodedMessage.type)")
        }
    }
    
    public func load(_ playerSettings: PlayerSettings) {
        callFunction("load", args: [playerSettings])
    }
    
    public func setPlayerStyle(_ playerStyle: String) {
        setProp("playerStyle", value: playerStyle)
    }
    
    private func commonInit() {
        clipsToBounds = true
        
        webViewContainer.translatesAutoresizingMaskIntoConstraints = false
        addSubview(webViewContainer)
        webViewContainer.topAnchor.constraint(equalTo: topAnchor).isActive = true
        webViewContainer.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        webViewContainer.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        let heightConstraint = heightAnchor.constraint(equalTo: webViewContainer.heightAnchor)
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webViewContainer.addSubview(webView)
        webView.topAnchor.constraint(equalTo: webViewContainer.topAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: webViewContainer.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: webViewContainer.rightAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: webViewContainer.bottomAnchor).isActive = true
    }
    
    private func onReady() {
        ready = true
        pendingCommands.forEach { exec($0) }
        pendingCommands.removeAll()
    }
    
    private func onResize(width: Int, height: Int) {
        webViewContainerHeightConstraint.constant = CGFloat(height)
    }
    
    private func onEvent(event: PlayerEvent, settings: PlayerSettings) {
        print("HII \(event) \(settings)")
    }
    
    private func setProp(_ name: String, value: Encodable) {
        guard let encodedValue = try? jsonEncoder.encode(value) else { return }
        guard let encodedStringValue = String(data: encodedValue, encoding: .utf8) else { return }
        exec(String(
            format: "%@ = %@",
            name,
            encodedStringValue
        ))
    }
    
    private func callFunction(_ name: String, args: Array<Encodable>) {
        guard let encodedArgs = try? args.map({ try jsonEncoder.encode($0) }) else { return }
        guard let encodedStringArgs = try? encodedArgs.map({
            guard let encodedStringArg = String(data: $0, encoding: .utf8) else { throw NSError() }
            return encodedStringArg
        }) else { return }
        exec(String(
            format: "%@(%@)",
            name,
            encodedStringArgs.joined(separator: ",")
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
