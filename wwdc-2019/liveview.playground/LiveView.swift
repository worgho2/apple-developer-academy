/*:
 # The Deep Dive

 */

//#-hidden-code
import PlaygroundSupport
import UIKit
import MetalPerformanceShaders

let controller : LiveViewOceanController = LiveViewOceanController()
controller.preferredContentSize = CGSize(width: ScreenSize.width.rawValue, height: ScreenSize.height.rawValue)
PlaygroundPage.current.liveView = controller
PlaygroundPage.current.needsIndefiniteExecution = true

//#-end-hidden-code
