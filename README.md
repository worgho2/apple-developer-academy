# apple-developer-academy

Projects developed during my time at the Apple Developer Academy: challenge apps, WWDC scholarship submissions, experiments and reusable modules, mostly in Swift for iOS and watchOS. Each folder is a self-contained project that used to live in its own repository and carries its own README with build and run instructions.

Binary assets (images, audio, video, fonts, design files, prebuilt frameworks) are stored with Git LFS. Run `git lfs install` before cloning to fetch them.

## Application video

The video I submitted when applying to the Apple Developer Academy: [watch on YouTube](https://www.youtube.com/watch?v=zFPs427mMX8).

## Projects

### [2x-audio-player](2x-audio-player)

iOS player for listening to audio shared from other apps at higher speeds. Audio arrives through a share-sheet Action extension, playback rate and skipping are handled by an AVAudioPlayer wrapper, and Apple's Speech framework transcribes the audio on device.

### [br-quiz](br-quiz)

Two-choice trivia quiz about Brazil grouped by Sustainable Development Goal themes, in Portuguese and English. Players pick a nationality, and scores go to a Firebase Realtime Database leaderboard split between Brazilian and international players, charted in the app.

### [donut-forget](donut-forget)

Small SwiftUI to-do app written while learning the framework. Tasks have a name, completion flag and priority, with one tab per priority and sheets to create and edit tasks. Everything is kept in memory.

### [event-networking-app](event-networking-app)

Networking app for events on iOS. Users create events with a name, date and cover photo and collect cards of the people they meet there, with photo, phrase, interest and what they are looking for, after a welcome and walkthrough flow. Firebase Analytics is wired in through CocoaPods.

### [graph-algorithms](graph-algorithms)

Sound Nodes, an iOS app where you draw a graph by tapping nodes and dragging edges, then watch the DSATUR graph-coloring algorithm color it one vertex per step in a SpriteKit scene.

### [integrated-budget](integrated-budget)

Two-part system connecting car mechanics with parts vendors. The iOS app lets vendors list parts and mechanics assemble repair budgets on Firebase, and a Node.js service emails the finished parts list through SendGrid.

### [jealous-partner](jealous-partner)

Comedy game where a jealous partner interrogates you over chat and demands photo proof of a specific object. You swipe between excuses, photograph the object, and Vision with Core ML (Inceptionv3) decides whether the picture convinces them.

### [kitura-journaling-api](kitura-journaling-api)

Swift backend on the Kitura framework, generated from IBM's Swift Server Generator scaffold. It stores users in PostgreSQL, authenticates with HTTP Basic, and exposes a CRUD API for short journal entries called reflexions, plus health, metrics and OpenAPI endpoints.

### [oraculo](oraculo)

SwiftUI app for the second Nano Challenge that helps educators track students: classes, grades per term, and behavioural occurrences, with search, PDF term reports and admin access levels, all on mock data.

### [otavi-os](otavi-os)

Windows XP style desktop for iOS built for the first Nano Challenge as a rewrite of the Windows 98 Crash app. It boots into a desktop with console, Internet Explorer, Notepad, alerts and shutdown, with classic sounds and haptic typing feedback. Challenge deliverables are included.

### [share-on-social](share-on-social)

Proof of concept for sharing photos to TikTok from an iOS app through the TikTok OpenSDK, with a facade that documents the required Info.plist setup and a photo library picker.

### [splash-it-color-game](splash-it-color-game)

Splash It, a color-matching arcade game for the fourth Nano Challenge. Drops fall onto a wheel that the player rotates with one thumb so each drop lands on its own color, with obstacles, power-ups, haptics, Game Center, Crashlytics and ads.

### [swift-audio-module](swift-audio-module)

Reusable AVFoundation module for background music, intro-then-loop tracks and overlapping sound effects, coordinated by a singleton manager. Shipped with a minimal host app and reused by other projects here.

### [swift-extensions](swift-extensions)

Grab-bag of small Swift extensions for CoreGraphics vector math, SpriteKit positioning and coordinate conversion, UIView tap gestures and UILabel styling. Copy the files you need.

### [synth-pure-data](synth-pure-data)

iOS synthesizer that runs Pure Data patches through libpd, delivered both as an app with a switch and slider UI and as an Audio Unit v3 extension so other audio apps can host it.

### [watch-health-tree](watch-health-tree)

watchOS app from a team challenge where you grow a virtual tree on the Apple Watch. HealthKit stand and move data become the sun and water you feed the plant, the Digital Crown zooms the SpriteKit tree, and a complication and notification controller are included.

### [windows-98-crash](windows-98-crash)

Crash Challenge app: a Windows 98 desktop that keeps crashing with random error dialogs and blue screens, complete with the original startup, shutdown and critical sounds. Later rebuilt as otaviOS.

### [wwdc-2019](wwdc-2019)

Spitro, the WWDC 2019 scholarship playground book. Text-based SpriteKit creatures orbit, spin and change color, and the pages let you tweak their parameters and observe the collective. Includes the exploratory playgrounds and an ocean live view experiment.

### [wwdc-2020](wwdc-2020)

WWDC 2020 Swift Student Challenge playground book built on Apple's template: a map-coloring puzzle where neighbouring regions cannot share a color, the constraint behind the DSATUR algorithm. Includes the live view test app and Apple's support frameworks.
