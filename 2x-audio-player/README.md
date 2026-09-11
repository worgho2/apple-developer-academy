# 2x-audio-player

iOS app (2xSpeedAudio) for listening to audio shared from other apps at faster speeds, built at the Apple Developer Academy.

Audio reaches the app through an Action extension in the share sheet (`action/`), so any audio file from Messages, WhatsApp or Files can be opened in the player. `AudioPlayer.swift` wraps `AVAudioPlayer` with rate control, skip forward and backward, and playback observers. `NativeTranscriptor.swift` uses Apple's Speech framework to transcribe the audio on device. The main target has a tab bar with the player, a settings screen and a video tutorial (`Tutorial/model/movies/demo.MP4`).

## Run

Open `2xSpeedAudio.xcodeproj` in Xcode and run the `2xSpeedAudio` scheme. Swift 5, iOS 13.0 or later. The Action extension needs a device or simulator with another app to share audio from.
