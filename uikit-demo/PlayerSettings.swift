public struct PlayerSettings: Codable {
    var playerApiUrl: String? = nil
    var projectId: Int? = nil
    var contentId: String? = nil
    var playlistId: Int? = nil
    var sourceId: String? = nil
    var sourceUrl: String? = nil
    var playlist: [Identifier]? = nil
    var showUserInterface: Bool? = nil
    var playerStyle: String? = nil
    var playerTitle: String? = nil
    var callToAction: String? = nil
    var skipButtonStyle: String? = nil
    var playlistStyle: String? = nil
    var playlistToggle: String? = nil
    var mediaSession: String? = nil
    var content: [Content]? = nil
    var contentIndex: Int? = nil
    var introsOutros: [IntroOutro]? = nil
    var introsOutrosIndex: Int? = nil
    var adverts: [Advert]? = nil
    var advertIndex: Int? = nil
    var persistentAdImage: Bool? = nil
    var persistentIndex: Int? = nil
    var duration: Float? = nil
    var currentTime: Float? = nil
    var playbackState: String? = nil
    var playbackRate: Float? = nil
    var textColor: String? = nil
    var backgroundColor: String? = nil
    var iconColor: String? = nil
    var logoIconEnabled: Bool? = nil
    var currentSegment: Segment? = nil
    var advertConsent: String? = nil
    var analyticsConsent: String? = nil
    var analyticsCustomUrl: String? = nil
    var analyticsTag: String? = nil
    var captureErrors: Bool? = nil
    
    public struct Identifier: Codable {
        var contentId: String? = nil
        var playlistId: Int? = nil
        var sourceId: String? = nil
        var sourceUrl: String? = nil
    }
    
    
    public struct Media: Codable {
        var id: Int? = nil
        var url: String? = nil
        var contentType: String? = nil
    }
    
    public struct Segment : Codable {
        var segmentIndex: Int? = nil
        var contentIndex: Int? = nil
        var marker: String? = nil
        var section: String? = nil
        var startTime: Float? = nil
        var duration: Float? = nil
    }
    
    public struct Content : Codable {
        var id: String? = nil
        var title: String? = nil
        var imageUrl: String? = nil
        var sourceId: String? = nil
        var sourceUrl: String? = nil
        var adsEnabled: Bool? = nil
        var duration: Float? = nil
        var media: [Media]? = nil
        var segments: [Segment]? = nil
    }
    
    public struct IntroOutro: Codable{
        var placement: String? = nil
        var media: [Media]? = nil
    }
    
    public struct Advert: Codable {
        var id: Int? = nil
        var type: String? = nil
        var placement: String? = nil
        var clickThroughUrl: String? = nil
        var vastUrl: String? = nil
        var textColor: String? = nil
        var backgroundColor: String? = nil
        var iconColor: String? = nil
        var media: [Media]? = nil
    }
}
