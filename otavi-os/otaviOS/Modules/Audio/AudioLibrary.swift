import AVFoundation

enum SongLibrary : String, CaseIterable {
    case startup = "Windows XP Startup.wav"
    case shutdown = "Windows XP Shutdown.wav"
}

enum IntroWithLoopLibrary: CaseIterable {
    case test
    
    var info : (intro: String, loop: String) {
        switch self {
        case .test:
            return ("Windows XP Startup.wav", "Windows XP Error.wav")
        }
    }
}

enum SoundEffectLibrary : String, CaseIterable {
    case error = "Windows XP Error.wav"
    case exclamation = "Windows XP Exclamation.wav"
    case hardwareInsert = "Windows XP Hardware Insert.wav"
    case hardwareRemove = "Windows XP Hardware Remove.wav"
    case printComplete = "Windows XP Print complete.wav"
    case start = "Windows XP Start.wav"
    case informationBar = "Windows XP Information Bar.wav"
    case menuCommand = "Windows XP Menu Command.wav"
    case startup = "Windows XP Startup.wav"
    case shutdown = "Windows XP Shutdown.wav"
    case beep = "beep.wav"
}
