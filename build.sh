xcodebuild archive \
    -scheme BeyondWordsPlayer \
    -configuration Release \
    -sdk iphonesimulator \
    -archivePath './build/BeyondWordsPlayer.framework-iphonesimulator.xcarchive' \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    SKIP_INSTALL=NO

xcodebuild archive \
    -scheme BeyondWordsPlayer \
    -configuration Release \
    -sdk iphoneos \
    -archivePath "./build/BeyondWordsPlayer.framework-iphoneos.xcarchive" \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    SKIP_INSTALL=NO

xcodebuild -create-xcframework \
    -framework "./build/BeyondWordsPlayer.framework-iphoneos.xcarchive/Products/Library/Frameworks/BeyondWordsPlayer.framework" \
    -framework "./build/BeyondWordsPlayer.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/BeyondWordsPlayer.framework" \
    -output "./build/BeyondWordsPlayer.xcframework"
