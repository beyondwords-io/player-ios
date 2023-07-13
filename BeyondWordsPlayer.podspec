# Run `pod lib lint` after editing this file.

Pod::Spec.new do |s|
  s.name           = 'BeyondWordsPlayer'
  s.version        = '0.0.1'
  s.summary        = 'The BeyondWords Player for iOS.'
  s.description    = 'A wrapper around the BeyondWords web player: https://github.com/beyondWords-io/player'
  s.homepage       = 'https://github.com/beyondwords-io/player-ios'
  s.license        = { :type => 'Proprietary', :file => 'LICENSE' }
  s.author         = { 'BeyondWords Developers' => 'support@beyondwords.io' }
  s.source         = { :git => 'https://github.com/beyondWords-io/player-ios.git', :tag => '0.0.1' }
  s.swift_versions = '4.0'
  s.source_files   = '*'
  s.platform       = :ios, '14.0'
end
