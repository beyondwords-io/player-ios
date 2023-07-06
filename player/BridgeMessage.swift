//
//  BridgeMessage.swift
//  player
//
//  Created by Nikola Hristov on 6.07.23.
//

struct BridgeMessage: Decodable {
    var type: String
    var event: PlayerEvent? = nil
    var settings: PlayerSettings? = nil
    var width: Int? = nil
    var height: Int? = nil
}
