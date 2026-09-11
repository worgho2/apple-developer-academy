# br-quiz

BRQuiz (bundle name "SDG Quiz") is an iOS quiz about Brazil built at the Apple Developer Academy. Questions are two-choice facts about the country grouped by Sustainable Development Goal themes such as population, territory, mortality, incarceration, energy, economy, immigration and education, for example which value is closest to Brazil's population.

Questions are localized in Portuguese and English. Players pick their nationality first, and after answering see their own score and a leaderboard split between Brazilian and international players, stored in Firebase Realtime Database and drawn with the Charts library. Firebase Auth identifies players and push notifications are registered at launch. Dependencies come from CocoaPods. `docs/` holds the Sketch sources for the app icon and assets.

## Run

```bash
pod install
```

Open `sdg quiz.xcworkspace` in Xcode and run. Swift 5, iOS 12.0 or later. `GoogleService-Info.plist` is not included. Download one from your own Firebase project and add it to the `sdg quiz` target before building.
