//
//  BridgeMessage.swift
//  BeyondWordsPlayer
//
//  Created by Nikola Hristov on 6.07.23.
//

struct BridgeMessage: Decodable {
    var type: String
    var event: PlayerEvent? = nil
    var settings: PlayerSettings? = nil
    var width: Float? = nil
    var height: Float? = nil
}
