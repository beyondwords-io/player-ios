//
//  PlayerView.swift
//  BeyondWordsPlayer
//
//  Created by Nikola Hristov on 6.07.23.
//

import UIKit
import WebKit

public class PlayerView: UIView {
    
    public weak var delegate: PlayerDelegate?
    
    private lazy var webViewContainer = {
        UIView()
    }()
    
    private lazy var webView = {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = .all
        let contentController = WKUserContentController()
        contentController.add(bridge, name: bridge.name)
        configuration.userContentController = contentController
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.scrollView.bounces = false
        webView.scrollView.isScrollEnabled = false
        guard let playerHTMLPath = Bundle(for: PlayerView.self).path(forResource: "player", ofType: "html") else {
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
    
    private lazy var bridge = {
        let bridge = Bridge("iOSBridge")
        bridge.delegate = self
        return bridge
    }()
    
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
    
    deinit {
        webView.stopLoading()
        webView.configuration.userContentController.removeAllScriptMessageHandlers()
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
        delegate?.player(self, onEvent: event, settings: settings)
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
            webView.evaluateJavaScript(command) { (result, error) in
                if let error {
                    print("PlayerView:exec: \(error)")
                }
            }
        }
    }
}

extension PlayerView : BridgeDelegate {
    func bridge(_ bridge: Bridge, didReceive message: BridgeMessage) {
        if (self.bridge != bridge) { return }
        
        switch (message.type) {
        case "ready":
            onReady()
        case "resize":
            onResize(width: message.width!, height: message.height!)
        case "event":
            onEvent(event: message.event!, settings: message.settings!)
        default:
            print("Unknown message received from iOSBridge \(message.type)")
        }
    }
}

extension PlayerView {
    public func load(_ playerSettings: PlayerSettings) {
        callFunction("load", args: [playerSettings])
    }
    
    public func setPlayerApiUrl(_ playerApiUrl: String) {
        setProp("player.playerApiUrl", value: playerApiUrl)
    }
    
    public func setProjectId(_ projectId: Int) {
        setProp("player.projectId", value: projectId)
    }
    
    public func setContentId(_ contentId: String) {
        setProp("player.contentId", value: contentId)
    }
    
    public func setPlaylistId(_ playlistId: Int) {
        setProp("player.playlistId", value: playlistId)
    }
    
    public func setSourceId(_ sourceId: String) {
        setProp("player.sourceId", value: sourceId)
    }
    
    public func setSourceUrl(_ sourceUrl: String) {
        setProp("player.sourceUrl", value: sourceUrl)
    }
    
    public func setPlaylist(_ playlist: [PlayerSettings.Identifier]) {
        setProp("player.playlist", value: playlist)
    }
    
    public func setShowUserInterface(_ showUserInterface: Bool) {
        setProp("player.showUserInterface", value: showUserInterface)
    }
    
    public func setPlayerStyle(_ playerStyle: String) {
        setProp("player.playerStyle", value: playerStyle)
    }
    
    public func setPlayerTitle(_ playerTitle: String) {
        setProp("player.playerTitle", value: playerTitle)
    }
    
    public func setCallToAction(_ callToAction: String) {
        setProp("player.callToAction", value: callToAction)
    }
    
    public func setSkipButtonStyle(_ skipButtonStyle: String) {
        setProp("player.skipButtonStyle", value: skipButtonStyle)
    }
    
    public func setPlaylistStyle(_ playlistStyle: String) {
        setProp("player.playlistStyle", value: playlistStyle)
    }
    
    public func setPlaylistToggle(_ playlistToggle: String) {
        setProp("player.playlistToggle", value: playlistToggle)
    }
    
    public func setMediaSession(_ mediaSession: String) {
        setProp("player.mediaSession", value: mediaSession)
    }
    
    public func setContent(_ content: [PlayerSettings.Content]) {
        setProp("player.content", value: content)
    }
    
    public func setContentIndex(_ contentIndex: Int) {
        setProp("player.contentIndex", value: contentIndex)
    }
    
    public func setIntrosOutros(_ introsOutros: [PlayerSettings.IntroOutro]) {
        setProp("player.introsOutros", value: introsOutros)
    }
    
    public func setIntrosOutrosIndex(_ introsOutrosIndex: Int) {
        setProp("player.introsOutrosIndex", value: introsOutrosIndex)
    }
    
    public func setAdverts(_ adverts: [PlayerSettings.Advert]) {
        setProp("player.adverts", value: adverts)
    }
    
    public func setAdvertIndex(_ advertIndex: Int) {
        setProp("player.advertIndex", value: advertIndex)
    }
    
    public func setPersistentAdImage(_ persistentAdImage: Bool) {
        setProp("player.persistentAdImage", value: persistentAdImage)
    }
    
    public func setPersistentIndex(_ persistentIndex: Int) {
        setProp("player.persistentIndex", value: persistentIndex)
    }
    
    public func setCurrentTime(_ currentTime: Float) {
        setProp("player.currentTime", value: currentTime)
    }
    
    public func setPlaybackState(_ playbackState: String) {
        setProp("player.playbackState", value: playbackState)
    }
    
    public func setPlaybackRate(_ playbackRate: Float) {
        setProp("player.playbackRate", value: playbackRate)
    }
    
    public func setTextColor(_ textColor: String) {
        setProp("player.textColor", value: textColor)
    }
    
    public func setBackgroundColor(_ backgroundColor: String) {
        setProp("player.backgroundColor", value: backgroundColor)
    }
    
    public func setIconColor(_ iconColor: String) {
        setProp("player.iconColor", value: iconColor)
    }
    
    public func setLogoIconEnabled(_ logoIconEnabled: Bool) {
        setProp("player.logoIconEnabled", value: logoIconEnabled)
    }
    
    public func setAdvertConsent(_ advertConsent: String) {
        setProp("player.advertConsent", value: advertConsent)
    }
    
    public func setAnalyticsConsent(_ analyticsConsent: String) {
        setProp("player.analyticsConsent", value: analyticsConsent)
    }
    
    public func setAnalyticsCustomUrl(_ analyticsCustomUrl: String) {
        setProp("player.analyticsCustomUrl", value: analyticsCustomUrl)
    }
    
    public func setAnalyticsTag(_ analyticsTag: String) {
        setProp("player.analyticsTag", value: analyticsTag)
    }
    
    public func setCaptureErrors(_ captureErrors: Bool) {
        setProp("player.captureErrors", value: captureErrors)
    }
}
