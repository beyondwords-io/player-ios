//
//  PlayerDelegate.swift
//  BeyondWordsPlayer
//
//  Created by Nikola Hristov on 6.07.23.
//

public protocol PlayerDelegate: AnyObject {
    func player(_ playerView: PlayerView, onEvent event: PlayerEvent, settings: PlayerSettings)
}
