import PlaygroundSupport
import SpriteKit

class GameScene: SKScene {
    
    private var label1 = SKLabelNode()
    
    private var canCallSpin: Bool = true
    private var startSpin: Bool = false
    
    override func didMove(to view: SKView) {
        
        label1.verticalAlignmentMode = .center
        //starting elements
        label1.position = CGPoint(x: 256, y: 384)
        label1.text = "Physics"
        label1.fontSize = 82
        label1.fontColor = UIColor.white
        label1.fontName = "Lucida console"
        label1.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        addChild(label1)
        
        backgroundColor = UIColor.black
    }
    
    public func label1Spin() {
        Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false, block: {(timer) in
            self.startSpin = true
        })
    }
    
    override func update(_ currentTime: TimeInterval) {
        if self.canCallSpin {
            self.label1Spin()
            self.canCallSpin = !self.canCallSpin
        }
        if self.startSpin { self.label1.run(SKAction.rotate(byAngle: 2.3, duration: 60)) }
        
    }
}

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 512, height: 768))
let scene = GameScene(size: CGSize(width: 512, height: 768))
sceneView.presentScene(scene)
PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
