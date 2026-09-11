/*:
# Now that you know basically what elements we are interacting with.
It's time to customize Spitro's creation parameters and observe that even if they're made of the same principles the collective is especially unpredictable.
*/
//#-hidden-code
import PlaygroundSupport
import SpriteKit

public class Spitro : SKNode {
    
    private var label = SKLabelNode()
    
    private var rotationSpeed: CGFloat = 0.0
    
    private var allowColorChange: Bool = true
    private var blendFactor: CGFloat = 0.0
    
    convenience init(fontColor: UIColor, text: String, textFont: String, transparency: CGFloat, textFontSize: CGFloat, rotationSpeed: CGFloat, allowColorChange: Bool, blendFactor: CGFloat) {
        self.init()
        addChild(label)
        
        label.text = text
        label.fontName = textFont
        label.alpha = transparency
        label.fontSize = textFontSize
        label.fontColor = fontColor
        label.alpha = 1.0
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        
        self.blendFactor = blendFactor
        self.allowColorChange = allowColorChange
        self.rotationSpeed = rotationSpeed
    }
    
    //rotate the spitro
    public func rotate() {
        self.label.run(SKAction.rotate(byAngle: self.rotationSpeed, duration: 80))
    }
    
    public func touchDown() {
        self.label.run(SKAction.sequence([.scale(to: 1.5, duration: 0.2), .scale(to: 1.0, duration: 0.1), .wait(forDuration: 3), .colorize(with: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), colorBlendFactor: 1.0, duration: .random(in: 1...5))]))
    }
    
    public func touchMoved() {
        self.label.run(SKAction.colorize(with: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), colorBlendFactor: 1.0, duration: .random(in: 1...5)))
    }
    
    public func touchUp() {
        self.label.run(SKAction.colorize(with: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), colorBlendFactor: 1.0, duration: .random(in: 1...5)))
    }
    
    public func changeColor() {
        if self.allowColorChange {
            self.label.run(SKAction.colorize(with: UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0), colorBlendFactor: self.blendFactor, duration: 0.02))
        }
    }
}



public class GameScene: SKScene {
    
    let newSpitro = Spitro(fontColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), text: "}{?...?}{", textFont: "lucida console", transparency: 1.0, textFontSize: 72, rotationSpeed: 2.3, allowColorChange: true, blendFactor: 0.5)
    private var canChangeColor: Bool = false
    
    override public func didMove(to view: SKView) {
        newSpitro.position = CGPoint(x: 0, y: 0)
        addChild(newSpitro)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        self.scene?.run(SKAction.playSoundFileNamed("bop3.mp3", waitForCompletion: true))
        self.newSpitro.touchDown()
        self.canChangeColor = !self.canChangeColor
    }

    
    func touchMoved(toPoint pos : CGPoint) {
        self.newSpitro.touchMoved()
    }
    
    func touchUp(atPoint pos : CGPoint) {
        self.newSpitro.touchMoved()
        self.canChangeColor = !self.canChangeColor
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    override public func update(_ currentTime: TimeInterval) {
        if self.canChangeColor { self.newSpitro.changeColor() }
        self.newSpitro.rotate()
    }
}

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 512, height: 768))
if let scene = GameScene(fileNamed: "GameScene") {
    scene.scaleMode = .aspectFill
    sceneView.presentScene(scene)
}
PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
//#-end-hidden-code
