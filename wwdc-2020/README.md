# wwdc-2020

My Swift Playgrounds submission for the WWDC 2020 Swift Student Challenge, built at the Apple Developer Academy on Apple's playground book template. It is a map-coloring puzzle: tap regions to paint them, long press to clear, and satisfy the rule that neighbouring spaces cannot share a color while every space gets painted, the same constraint the DSATUR graph-coloring algorithm solves.

`Template/PlaygroundBook` is the book (`Chapters/Chapter1`, with an intro cutscene and one playground page), `BookCore` holds the live view controller and cutscene view, and `BookAPI` and `UserModule` are the template's user-facing modules. `LiveViewTestApp` runs the live view as a normal iOS app for debugging. `SupportingContent/` contains Apple's PlaygroundSupport, PlaygroundBluetooth and LiveViewHost frameworks for device, simulator and Mac Catalyst. Apple's template license and acknowledgements are at the root.

## Run

Open `Template/PlaygroundBook.xcodeproj` in Xcode 11 or later. Build the `PlaygroundBook` scheme to produce the `.playgroundbook`, or run `LiveViewTestApp` in the simulator. Swift 5.1, iOS 13.0.
