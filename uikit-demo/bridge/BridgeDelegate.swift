protocol BridgeDelegate : AnyObject {
    func bridge(_ bridge: Bridge, didReceive message: BridgeMessage)
}
