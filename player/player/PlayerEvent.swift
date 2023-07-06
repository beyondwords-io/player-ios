//
//  PlayerEvent.swift
//  player
//
//  Created by Nikola Hristov on 6.07.23.
//

public struct PlayerEvent: Codable {
    var id: String
    var type: String
    var description: String
    var initiatedBy: String
    var emittedFrom: String
    var status: String
    var createdAt: String
    var processedAt: String
    // TODO var changedProps
}