# share-on-social

iOS proof of concept built at the Apple Developer Academy for sharing photos to TikTok from inside an app.

`TikTokFacade.swift` wraps the TikTok OpenSDK: it documents the Info.plist entries the SDK needs (client key, URL scheme, query schemes), requests photo library access, and hands the selected images to TikTok's share flow. `ViewController` uses QBImagePickerController to pick items from the library. Dependencies come from CocoaPods.

## Run

```bash
pod install
```

Open `Share on Social.xcworkspace` in Xcode, set your own TikTok client key in Info.plist as described in the facade's header comment, and run on a device with TikTok installed. Swift 5, iOS 13.0 or later.
