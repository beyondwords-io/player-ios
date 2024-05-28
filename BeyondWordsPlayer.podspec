Pod::Spec.new do |s|
  s.name           = 'BeyondWordsPlayer'
  s.version        = '0.1.13'
  s.summary        = 'The BeyondWords Player for iOS.'
  s.description    = 'A wrapper around the BeyondWords web player: https://github.com/beyondWords-io/player'
  s.homepage       = 'https://github.com/beyondwords-io/player-ios'
  s.license        = { :type => 'Proprietary', :file => 'LICENSE' }
  s.author         = { 'BeyondWords Developers' => 'support@beyondwords.io' }
  s.source         = { :git => 'https://github.com/beyondWords-io/player-ios.git', :tag => s.version.to_s }
  s.source_files   = "BeyondWordsPlayer/BeyondWordsPlayer/**/*.{swift}"
  s.resources      = 'BeyondWordsPlayer/BeyondWordsPlayer/player.html'

  s.ios.deployment_target = '13.0'
  s.swift_versions = '5.0'
end
