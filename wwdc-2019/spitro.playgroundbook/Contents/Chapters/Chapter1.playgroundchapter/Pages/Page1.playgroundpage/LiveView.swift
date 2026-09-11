import PlaygroundSupport
import SpriteKit

class GameScene: SKScene {
    
    private var label1 = SKLabelNode()
    private var label2 = SKLabelNode()
    
    override func didMove(to view: SKView) {
        self.addChild(label1)
        label1.verticalAlignmentMode = .center
        label1.position = CGPoint(x: 229, y: 385.0)
        label1.text = "Spitr"
        label1.fontSize = 100
        label1.fontColor = UIColor.white
        label1.fontName = "Optima Regular"
        label1.color = UIColor.black
        
        self.addChild(label2)
        label2.verticalAlignmentMode = .center
        label2.position = CGPoint(x: 352, y: 385.0)
        label2.text = "o"
        label2.fontSize = 100
        label2.fontColor = UIColor.white
        label2.fontName = "Optima Regular"
        label2.color = UIColor.black
        
        self.backgroundColor = UIColor.black
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.label2.run(SKAction.rotate(byAngle: 5, duration: 60))
        self.label2.run(SKAction.colorize(with: UIColor(red: .random(in: 0...1),
                                                        green: .random(in: 0...1),
                                                        blue: .random(in: 0...1),
                                                        alpha: 1.0), colorBlendFactor: 0.4, duration: 0.02))
    }
}

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 512, height: 768))
let scene = GameScene(size: CGSize(width: 512, height: 768))
sceneView.presentScene(scene)
PlaygroundPage.current.liveView = sceneView
PlaygroundPage.current.needsIndefiniteExecution = true
