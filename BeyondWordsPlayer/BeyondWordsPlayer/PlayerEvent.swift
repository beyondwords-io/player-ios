//
//  PlayerEvent.swift
//  BeyondWordsPlayer
//
//  Created by Nikola Hristov on 6.07.23.
//

public struct PlayerEvent: Codable {
    public var id: String
    public var type: String
    public var description: String
    public var initiatedBy: String
    public var emittedFrom: String
    public var status: String
    public var createdAt: String
    public var processedAt: String
    // TODO var changedProps
    
    public init(id: String, type: String, description: String, initiatedBy: String, emittedFrom: String, status: String, createdAt: String, processedAt: String) {
        self.id = id
        self.type = type
        self.description = description
        self.initiatedBy = initiatedBy
        self.emittedFrom = emittedFrom
        self.status = status
        self.createdAt = createdAt
        self.processedAt = processedAt
    }
}
