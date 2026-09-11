# synth-pure-data

iOS synthesizer built at the Apple Developer Academy that runs Pure Data patches on the device through libpd, packaged both as an app and as an Audio Unit extension.

The `SynthPD` app hosts the main view with a switch and a slider that drive the patch (`model/pure data/patch files/main.pd`, with `aml.pd` as a helper). The `augen` target is an Audio Unit v3 extension whose DSP kernel (C++ headers bridged through Objective-C++) exposes the synth to other audio apps such as GarageBand. libpd comes from CocoaPods.

## Run

```bash
pod install
```

Open `SynthPD.xcworkspace` in Xcode and run the app scheme. Swift 5, iOS 13.2 or later. To test the Audio Unit, run the `augen` scheme and choose a host app.
