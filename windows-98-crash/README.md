# windows-98-crash

iOS app built for the Crash Challenge at the Apple Developer Academy: a Windows 98 desktop that keeps crashing with the classic blue screen.

`StartupViewController` plays the boot sequence, `DesktopViewController` shows the desktop with My Computer, My Documents, Recycle Bin, Internet Explorer and Paint icons, and `CrashViewController` throws random error dialogs and blue screens with the original startup, shutdown and critical sounds. Discovered errors are collected in `ErrorTableViewController`. The challenge presentation is in `docs/keynote.key`. This concept was later rebuilt as `otavi-os`.

## Run

Open `Windows98Crash.xcodeproj` in Xcode and run. Swift 5, iOS 12.2 or later.
