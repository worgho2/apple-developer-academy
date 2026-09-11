# jealous-partner

Comedy iOS game built at the Apple Developer Academy about surviving a jealous partner's interrogation. The project, targets and bundle identifiers were renamed to Jealous Partner in this repository.

Each round starts with a chat message from the partner asking where you are and demanding photo proof of a specific object (a pizza, an ice cream, a pen, a cross, a guitar). You swipe to choose between two excuses (`SwipeViewController`), then use the camera to photograph the requested object (`ImageClassificationViewController`). Vision and Core ML classify the picture with Apple's Inceptionv3 model, and the round succeeds if the expected label appears in the results, otherwise the partner ends the relationship (`FailViewController`). Five rounds of dialogue, choices and expected answers live in `Manager.swift` as `Conversa`, `Escolha` and `Gabarito` entries, all in Portuguese.

## Run

Open `JealousPartner.xcodeproj` in Xcode. Download Apple's `Inceptionv3.mlmodel` from the Core ML models page and add it to the `JealousPartner` target, since the model is not committed. Run on a device with a camera. Swift 5, iOS 12.2 or later.
