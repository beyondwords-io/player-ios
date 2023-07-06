//
//  BridgeDelegate.swift
//  player
//
//  Created by Nikola Hristov on 6.07.23.
//

protocol BridgeDelegate : AnyObject {
    func bridge(_ bridge: Bridge, didReceive message: BridgeMessage)
}
