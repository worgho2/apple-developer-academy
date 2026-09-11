# watch-health-tree

watchOS app from an Apple Developer Academy team challenge (challenge 2, team Wachowski, hence the original repository name c2-wachowski). You grow a virtual tree on the Apple Watch, and its resources come from your own activity: HealthKit stand and move data are converted into sun and water that you feed to the plant.

`PlantFeeding.swift` in the WatchKit Extension drives the SpriteKit tree scene (`TreeScene`), reads resources from `ResourceModel`, and uses the Digital Crown to zoom. The WatchKit App holds the storyboard, the audio module and sound effects. A complication controller and a notification controller with a sample push payload are included. The README's Portuguese section documents the team's semantic versioning and branch conventions.

## Run

Open `c2-wachoski/c2-wachoski.xcodeproj` in Xcode and run the WatchKit App scheme on a watch simulator or paired device. Swift 5, watchOS 6.0 or later. HealthKit data is only available on a real device.

## Versionamento Semântico

#### *X.Y.PATCH*

* Incrementar X para mudanças incompatíveis na API
* Incrementar Y quando adicionar funcionalidades mantendo compatibilidade
* Incrementar PATCH quando corrigir falhas mantendo compatibilidade

## Branches

* *master*: Principal
* *release*: Inserção de novas funcionalidades
* *develop*: Desenvolvimento
* *feature/*: Desenvolvimento de novas Funcionalidades
* *hotfix/*: Correção de Bugs
