# swift-audio-module

Reusable AVFoundation audio module for iOS games and apps, written at the Apple Developer Academy and used by other projects in this repository (for example the nano challenge game and the watch app).

`Module/` contains the drop-in files: `Song` wraps `AVAudioPlayer` for background music, `IntroWithLoop` plays an intro once and then a seamless loop, `SoundEffect` manages several short effects that can overlap, `AudioLibrary` enumerates the bundled tracks, and `AudioManager` is the singleton that coordinates them. The surrounding app in `AudioModule/` is a minimal host that demonstrates the module with the sample tracks in `SoundTracks/`.

## Run

Open `AudioModule/AudioModule.xcodeproj` in Xcode and run, or copy the `Module/` folder into another project.
