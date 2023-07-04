public protocol PlayerDelegate : AnyObject {
    func player(_ player: PlayerView, onEvent event: PlayerEvent, settings: PlayerSettings)
}
