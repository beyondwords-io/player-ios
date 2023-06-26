import UIKit
import WebKit

class PlayerView: UIView, WKNavigationDelegate, WKScriptMessageHandler {
    private lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        let contentController = WKUserContentController()
        contentController.add(self, name: "iOSBridge")
        configuration.userContentController = contentController
        let view = WKWebView(frame: .zero, configuration: configuration)
        view.navigationDelegate = self
        view.scrollView.bounces = false
        view.scrollView.isScrollEnabled = false
#if DEBUG
        view.isInspectable = true
#endif
        let url = URL(string: "https://beyondwords-io.github.io/player-demo/")
        view.load(URLRequest(url: url!))
        return view;
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
        if message.name == "iOSBridge" {
            print("Hey", message.body)
        }
    }
}
