protocol BridgeDelegate : AnyObject {
    func bridge(_ bridge: Bridge, onMessage message: BridgeMessage)
}
