//
//  PlayerDelegate.swift
//  Player
//
//  Created by Nikola Hristov on 6.07.23.
//

public protocol PlayerDelegate: AnyObject {
    func player(_ player: PlayerView, onEvent event: PlayerEvent, settings: PlayerSettings)
}
