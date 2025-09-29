## Segments Playback

The player supports a feature called 'Playback from Segments'. This lets you to click on a segment in your app (i.e. a paragraph) to begin playback from that segment. If the segment is already playing then it will be paused instead.

The segments playback in the iOS Player is based on the [Segments Playback in the Web Player](https://github.com/beyondwords-io/player/blob/main/doc/segments-playback.md). The iOS SDK cannot automatically identify segments, instead you should be able to manually link each text segment with its beyondwords marker.

You can find an example of how segment playback can be integrated in your app in [PlaybackFromSegmentsViewController.swift](../Example/Example/PlaybackFromSegmentsViewController.swift)

## How it works

To highlight the current segment you have to listen for the `CurrentSegmentUpdated` event, then find the correspondig UI element to the `currentSegment` and apply the desired styling to it.

```swift
extension PlaybackFromSegmentsViewController : PlayerDelegate {
    public func player(_ playerView: PlayerView, onEvent event: PlayerEvent, settings: PlayerSettings) {
        if (self.playerView !== playerView) { return }
        
        if (event.type == "CurrentSegmentUpdated") {
            let text = settings.currentSegment?.marker.flatMap { self.segments[$0] }
            for view in self.contentView.arrangedSubviews {
                guard let label = view as? UILabel else { continue }
                if (label.text == text) {
                    label.backgroundColor = .lightGray
                } else {
                    label.backgroundColor = .clear
                }
            }
        }
    }
}
```

To change the current time of the player when a segment is clicked you have to set `UITapGestureRecognizer` and call `setCurrentSegment` with the correspondig marker.

```swift
@objc private func segmentTapped(_ gesture: UITapGestureRecognizer) {
    guard let label = gesture.view as? UILabel else { return }
    guard let marker = self.segments.first(where: { $0.value == label.text })?.key else { return }
    playerView.setCurrentSegment(segmentMarker: marker)
}
```
