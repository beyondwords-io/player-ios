//
//  PlayerSettings.swift
//  BeyondWordsPlayer
//
//  Created by Nikola Hristov on 6.07.23.
//

public struct PlayerSettings: Codable {
    public var playerApiUrl: String? = nil
    public var projectId: Int? = nil
    public var contentId: String? = nil
    public var playlistId: Int? = nil
    public var sourceId: String? = nil
    public var sourceUrl: String? = nil
    public var playlist: [Identifier]? = nil
    public var showUserInterface: Bool? = nil
    public var playerStyle: String? = nil
    public var playerTitle: String? = nil
    public var callToAction: String? = nil
    public var skipButtonStyle: String? = nil
    public var playlistStyle: String? = nil
    public var playlistToggle: String? = nil
    public var mediaSession: String? = nil
    public var content: [Content]? = nil
    public var contentIndex: Int? = nil
    public var introsOutros: [IntroOutro]? = nil
    public var introsOutrosIndex: Int? = nil
    public var adverts: [Advert]? = nil
    public var advertIndex: Int? = nil
    public var minDurationForMidroll: Float? = nil
    public var minTimeUntilEndForMidroll: Float? = nil
    public var persistentAdImage: Bool? = nil
    public var persistentIndex: Int? = nil
    public var duration: Float? = nil
    public var currentTime: Float? = nil
    public var playbackState: String? = nil
    public var playbackRate: Float? = nil
    public var textColor: String? = nil
    public var backgroundColor: String? = nil
    public var iconColor: String? = nil
    public var logoIconEnabled: Bool? = nil
    public var currentSegment: Segment? = nil
    public var loadedMedia: Media? = nil
    public var advertConsent: String? = nil
    public var analyticsConsent: String? = nil
    public var analyticsCustomUrl: String? = nil
    public var analyticsTag: String? = nil
    public var bundleIdentifier: String? = nil
    public var vendorIdentifier: String? = nil
    
    public struct Identifier: Codable {
        public var contentId: String? = nil
        public var playlistId: Int? = nil
        public var sourceId: String? = nil
        public var sourceUrl: String? = nil
        
        public init(contentId: String? = nil, playlistId: Int? = nil, sourceId: String? = nil, sourceUrl: String? = nil) {
            self.contentId = contentId
            self.playlistId = playlistId
            self.sourceId = sourceId
            self.sourceUrl = sourceUrl
        }
    }
    
    public struct Media: Codable {
        public var id: Int? = nil
        public var url: String? = nil
        public var contentType: String? = nil
        public var duration: Float? = nil
        public var format: String? = nil
        
        public init(id: Int? = nil, url: String? = nil, contentType: String? = nil, duration: Float? = nil, format: String? = nil) {
            self.id = id
            self.url = url
            self.contentType = contentType
            self.duration = duration
            self.format = format
        }
    }
    
    public struct Segment : Codable {
        public var segmentIndex: Int? = nil
        public var contentIndex: Int? = nil
        public var marker: String? = nil
        public var section: String? = nil
        public var startTime: Float? = nil
        public var duration: Float? = nil
        
        public init(segmentIndex: Int? = nil, contentIndex: Int? = nil, marker: String? = nil, section: String? = nil, startTime: Float? = nil, duration: Float? = nil) {
            self.segmentIndex = segmentIndex
            self.contentIndex = contentIndex
            self.marker = marker
            self.section = section
            self.startTime = startTime
            self.duration = duration
        }
    }
    
    public struct Content : Codable {
        public var id: String? = nil
        public var title: String? = nil
        public var imageUrl: String? = nil
        public var sourceId: String? = nil
        public var sourceUrl: String? = nil
        public var adsEnabled: Bool? = nil
        public var duration: Float? = nil
        public var audio: [Media]? = nil
        public var video: [Media]? = nil
        public var segments: [Segment]? = nil
        
        init(id: String? = nil, title: String? = nil, imageUrl: String? = nil, sourceId: String? = nil, sourceUrl: String? = nil, adsEnabled: Bool? = nil, duration: Float? = nil, audio: [Media]? = nil, video: [Media]? = nil, segments: [Segment]? = nil) {
            self.id = id
            self.title = title
            self.imageUrl = imageUrl
            self.sourceId = sourceId
            self.sourceUrl = sourceUrl
            self.adsEnabled = adsEnabled
            self.duration = duration
            self.audio = audio
            self.video = video
            self.segments = segments
        }
    }
    
    public struct IntroOutro: Codable {
        public var placement: String? = nil
        public var audio: [Media]? = nil
        public var video: [Media]? = nil
        
        public init(placement: String? = nil, audio: [Media]? = nil, video: [Media]? = nil) {
            self.placement = placement
            self.audio = audio
            self.video = video
        }
    }
    
    public struct Advert: Codable {
        public var id: Int? = nil
        public var type: String? = nil
        public var placement: String? = nil
        public var clickThroughUrl: String? = nil
        public var vastUrl: String? = nil
        public var textColor: String? = nil
        public var backgroundColor: String? = nil
        public var iconColor: String? = nil
        public var audio: [Media]? = nil
        public var video: [Media]? = nil
        
        public init(id: Int? = nil, type: String? = nil, placement: String? = nil, clickThroughUrl: String? = nil, vastUrl: String? = nil, textColor: String? = nil, backgroundColor: String? = nil, iconColor: String? = nil, audio: [Media]? = nil, video: [Media]? = nil) {
            self.id = id
            self.type = type
            self.placement = placement
            self.clickThroughUrl = clickThroughUrl
            self.vastUrl = vastUrl
            self.textColor = textColor
            self.backgroundColor = backgroundColor
            self.iconColor = iconColor
            self.audio = audio
            self.video = video
        }
    }
    
    public init(playerApiUrl: String? = nil, projectId: Int? = nil, contentId: String? = nil, playlistId: Int? = nil, sourceId: String? = nil, sourceUrl: String? = nil, playlist: [Identifier]? = nil, showUserInterface: Bool? = nil, playerStyle: String? = nil, playerTitle: String? = nil, callToAction: String? = nil, skipButtonStyle: String? = nil, playlistStyle: String? = nil, playlistToggle: String? = nil, mediaSession: String? = nil, content: [Content]? = nil, contentIndex: Int? = nil, introsOutros: [IntroOutro]? = nil, introsOutrosIndex: Int? = nil, adverts: [Advert]? = nil, advertIndex: Int? = nil, minDurationForMidroll: Float? = nil, minTimeUntilEndForMidroll: Float? = nil, persistentAdImage: Bool? = nil, persistentIndex: Int? = nil, duration: Float? = nil, currentTime: Float? = nil, playbackState: String? = nil, playbackRate: Float? = nil, textColor: String? = nil, backgroundColor: String? = nil, iconColor: String? = nil, logoIconEnabled: Bool? = nil, currentSegment: Segment? = nil, loadedMedia: Media? = nil, advertConsent: String? = nil, analyticsConsent: String? = nil, analyticsCustomUrl: String? = nil, analyticsTag: String? = nil) {
        self.playerApiUrl = playerApiUrl
        self.projectId = projectId
        self.contentId = contentId
        self.playlistId = playlistId
        self.sourceId = sourceId
        self.sourceUrl = sourceUrl
        self.playlist = playlist
        self.showUserInterface = showUserInterface
        self.playerStyle = playerStyle
        self.playerTitle = playerTitle
        self.callToAction = callToAction
        self.skipButtonStyle = skipButtonStyle
        self.playlistStyle = playlistStyle
        self.playlistToggle = playlistToggle
        self.mediaSession = mediaSession
        self.content = content
        self.contentIndex = contentIndex
        self.introsOutros = introsOutros
        self.introsOutrosIndex = introsOutrosIndex
        self.adverts = adverts
        self.advertIndex = advertIndex
        self.minDurationForMidroll = minDurationForMidroll
        self.minTimeUntilEndForMidroll = minTimeUntilEndForMidroll
        self.persistentAdImage = persistentAdImage
        self.persistentIndex = persistentIndex
        self.duration = duration
        self.currentTime = currentTime
        self.playbackState = playbackState
        self.playbackRate = playbackRate
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.iconColor = iconColor
        self.logoIconEnabled = logoIconEnabled
        self.currentSegment = currentSegment
        self.loadedMedia = loadedMedia
        self.advertConsent = advertConsent
        self.analyticsConsent = analyticsConsent
        self.analyticsCustomUrl = analyticsCustomUrl
        self.analyticsTag = analyticsTag
    }
}
