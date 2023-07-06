//
//  Bridge.swift
//  Player
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
              let messageData = messageString.data(using: .utf8),
              let decodedMessage = try? jsonDecoder.decode(BridgeMessage.self, from: messageData) else {
            print("Cannot decode BridgeMessage: \(message.body)")
            return
        }
        
        delegate?.bridge(self, didReceive: decodedMessage)
    }
}
