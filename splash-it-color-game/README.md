# splash-it-color-game

Splash It is an iOS color-matching arcade game built for the fourth Nano Challenge at the Apple Developer Academy.

A wheel with colored segments sits at the bottom of the screen and drops fall from the top. The player rotates the wheel with one thumb at a time so that each drop lands on the segment of its own color. Obstacles and power-ups (such as a color changer that swaps the palette) appear as the speed ramps up. The SpriteKit scene is organised around `GameObject` subclasses and factory and spawner pairs for drops, obstacles, power-ups and background blocks, with managers for score, speed, colors, audio, haptics, Game Center and onboarding. Firebase Crashlytics and Analytics and Google Mobile Ads are wired in through CocoaPods.

## Run

```bash
pod install
```

Then open `nano_challenge_4.xcworkspace` in Xcode and run. Swift 5, iOS 13.2 or later. `GoogleService-Info.plist` is not included. Download one from your own Firebase project and add it to the `nano_challenge_4` target before building.
