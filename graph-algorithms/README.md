# graph-algorithms

Sound Nodes is an iOS app built at the Apple Developer Academy for drawing a graph by hand and watching the DSATUR graph-coloring algorithm color it step by step.

In `GameScene` (SpriteKit) you tap to place nodes and drag between them to create edges. `GraphAlgorithms.stepDSATUR` then colors one vertex per step, always choosing the vertex with the highest saturation degree, and the scene updates node colors and marks uncolored neighbours. `Model` tracks whether a step is available and whether the algorithm is running, and `MenuViewController` lists the available modes. `docs/` holds the Sketch sources for the app icon and assets.

## Run

Open `Graph Algorithms.xcodeproj` in Xcode and run. Swift 5, iOS 12.2 or later.
