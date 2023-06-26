import UIKit
import WebKit

class PlayerView: UIView, WKNavigationDelegate, WKScriptMessageHandler {
    struct BridgeMessage: Codable {
        var type: String
    }
    
    private lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = .all
        let contentController = WKUserContentController()
        contentController.add(self, name: "iOSBridge")
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
    
    private lazy var jsonDecoded: JSONDecoder = {
        return JSONDecoder()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(webView)
        webView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        webView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        webView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        webView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        webView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("window.webkit.messageHandlers.iOSBridge.postMessage('trigger from JS');", completionHandler: nil)
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
        
        print(decodedMessage)
    }
}
