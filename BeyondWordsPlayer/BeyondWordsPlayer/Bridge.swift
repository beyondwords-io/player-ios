//
//  Bridge.swift
//  BeyondWordsPlayer
//
//  Created by Nikola Hristov on 6.07.23.
//

import WebKit

class Bridge : NSObject {
    
    public let name: String
    
    public weak var delegate: BridgeDelegate?
    
    private let jsonDecoder = JSONDecoder()
    
    init(_ name: String) {
        self.name = name
        super.init()
    }
}

extension Bridge : WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if self.name != message.name { return }
        
        guard let messageString = message.body as? String,
              let messageData = messageString.data(using: .utf8) else {
            print("Cannot decode BridgeMessage: \(message.body)")
            return
        }
        
        let decodedMessage: BridgeMessage
        do {
            decodedMessage = try jsonDecoder.decode(BridgeMessage.self, from: messageData)
        } catch {
            print("Cannot decode BridgeMessage: \(message.body) \(error)")
            return
        }
        
        delegate?.bridge(self, didReceive: decodedMessage)
    }
}
