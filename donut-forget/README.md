# donut-forget

Small SwiftUI to-do app built at the Apple Developer Academy while learning SwiftUI. Tasks have a name, a completion flag and a priority (none, low, medium, high).

`InitialTabView` shows one tab per priority, each listing its tasks (`TasksView`) with sheets to create (`NewTaskView`) and edit (`TaskEditView`) them. `TaskModel` is an observable object that holds the in-memory task list. There is no persistence.

## Run

Open `DonutForget.xcodeproj` in Xcode and run. Swift 5, iOS 13.2 or later.
