# event-networking-app

iOS networking app for events, built at the Apple Developer Academy. Users create events with a name, date and cover photo, then collect "figurinhas" (cards) of the people they meet there, each with a photo, name, a phrase, an interest and what that person is looking for at the event.

The UIKit app starts with a welcome and walkthrough flow, then lists events in `ListaEventosViewController` with screens to add an event and browse its cards. Firebase Analytics is configured in `AppDelegate`. Dependencies come from CocoaPods.

## Run

```bash
pod install
```

Open `aylto.xcworkspace` (not the `.xcodeproj`) in Xcode and run. Swift 5, iOS 13.1 or later. `GoogleService-Info.plist` is not included. Download one from your own Firebase project and add it to the `aylto` target before building.
