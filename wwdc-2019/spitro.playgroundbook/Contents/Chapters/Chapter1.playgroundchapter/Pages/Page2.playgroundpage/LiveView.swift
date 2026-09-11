import PlaygroundSupport
import SpriteKit

class GameScene: SKScene {
    
    private var label1 = SKLabelNode()
    private var label2 = SKLabelNode()
    
    private var canCallSpin: Bool = true
    private var startSpin: Bool = false
    
    override func didMove(to view: SKView) {
        
        label1.verticalAlignmentMode = .center
        //starting elements
        label1.position = CGPoint(x: 229, y: 384)
        label1.text = "Spitr"
        label1.fontSize = 100
        label1.fontColor = UIColor.white
        label1.fontName = "Optima Regular"
        label1.color = UIColor.black
        addChild(label1)
        
        label2.position = CGPoint(x:352, y:384)
        label2.text = "o"
        label2.fontSize = 100
        label2.fontColor = UIColor.white
        label2.fontName = "Optima Regular"
        label2.color = UIColor.black
        label2.verticalAlignmentMode = .center
        addChild(label2)
        
        backgroundColor = UIColor.black
    }
    
    public func label1Spin() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: {(timer) in
            self.startSpin = true
        })
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: {(timer) in
            self.label1.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.5), .fadeIn(withDuration: 2) ]))
            self.label2.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.5), .fadeIn(withDuration: 2) ]))
        })
        Timer.scheduledTimer(withTimeInterval: 3.5, repeats: false, block: {(timer) in
            self.label1.text = "wwdc"
            self.label2.text = "19"
            self.label1.run(SKAction.moveTo(x: 256, duration: 1))
            self.label2.run(SKAction.moveTo(x: 256, duration: 1))
        })
    }
    
    override func update(_ currentTime: TimeInterval) {
        if self.canCallSpin {
            self.label1Spin()
            self.canCallSpin = !self.canCallSpin
        }
        if self.startSpin { self.label1.run(SKAction.rotate(byAngle: 3, duration: 60)) }
        
        self.label2.run(SKAction.rotate(byAngle: 2, duration: 60))
        self.label2.run(SKAction.colorize(with: UIColor(red: .random(in: 0...1),
                                                        green: .random(in: 0...1),
                                                        blue: .random(in: 0...1),
                                                        alpha: 1.0), colorBlendFactor: 0.7, duration: 0.02))
    }
}

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 512, height: 768))
let scene = GameScene(size: CGSize(width: 512, height: 768))
sceneView.presentScene(scene)
PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
