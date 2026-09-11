/*:
# Now you know basically what elements we are interacting with.
It's time to customize Spitro's creation parameters and observe that even if they're made of the same principles the collective is especially unpredictable.
 
-----
**When touching the screen, the spitros will be moved randomly, as well as their orbits.**
 
**When sliding the screen, the spitro's orbit will become 0.**

**fontColor:**
- You can double tap the color square and choose another one

**text:**
- The text can contain 🤠👍👨‍💻 too.

**textFont:**
- "HelvetiCANEUE"
- "lucida console"
- "Georgia"
- "Futura"
- "Gil Sans"
- "Zapfino"
- "Marker Felt"
- "Herculanum"
- "Arial"
- "Impact"
- "Comic Sans MS"
- ...

**transparency:**
- Define how transparent your text will be.
- 0.0 to 1.0

**textFontSize:**
- Define how large your text will be.
- 9 to 288

**rotationSpeed:**
- Define how fast your text will rotate.
- 0.0 to 15.0

**orbitalSpeed:**
- Define how fast the orbit of your text will rotate.
- 0.0 to 15.0

**allowColorChange:**
- Define if the text will change the color when touched
- [true , false]

**blendFactor:**
- Define how transparent the color will be.
- 0.0 to 1.0
*/

//#-hidden-code
import PlaygroundSupport
import SpriteKit

public class Spitro : SKNode {
    
    private var label = SKLabelNode()
    
    private var horizontalPos: Double = 0.0
    private var verticalPos: Double = 0.0
    
    private var rotationSpeed: CGFloat = 0.0
    private var orbitalSpeed: CGFloat = 0.0
    
    private var allowColorChange: Bool = true
    private var blendFactor: CGFloat = 0.0
    
    convenience init(fontColor: UIColor, text: String, textFont: String, transparency: CGFloat, textFontSize: CGFloat, rotationSpeed: CGFloat, orbitalSpeed: CGFloat, allowColorChange: Bool, blendFactor: CGFloat) {
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
        self.orbitalSpeed = orbitalSpeed
        self.rotationSpeed = rotationSpeed
    }
    
    //rotate the spitro
    public func rotate() {
        self.label.run(SKAction.rotate(byAngle: self.speed, duration: 80))
        run(SKAction.rotate(byAngle: self.orbitalSpeed, duration: 80))
    }
    
    //generate random points
    public func getHorizontalPos() -> CGFloat { return CGFloat.random(in: -216...216) }
    public func getVerticalPos() -> CGFloat { return CGFloat.random(in: -344...344) }
    
    public func touchDown() {
        //scale up -> scale down -> return to white
        self.label.run(SKAction.sequence([.scale(to: 1.5, duration: 0.2), .scale(to: 1.0, duration: 0.1), .wait(forDuration: 3), .colorize(with: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), colorBlendFactor: 1.0, duration: .random(in: 1...5))]))
        
        //labelNode and labe random movement
        run(SKAction.moveTo(x: (self.getHorizontalPos()), duration: .random(in: 0.5...1)))
        run(SKAction.moveTo(y: (self.getVerticalPos()), duration: .random(in: 0.5...1)))
        self.label.run(SKAction.moveTo(x: self.getHorizontalPos()/6, duration: .random(in: 0.5...1)))
        self.label.run(SKAction.moveTo(y: self.getVerticalPos()/6, duration: .random(in: 0.5...1)))
    }
    
    public func touchMoved() {
        self.label.run(SKAction.colorize(with: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), colorBlendFactor: 1.0, duration: .random(in: 1...5)))
        self.label.run(SKAction.moveTo(x: 0, duration: 1.5))
        self.label.run(SKAction.moveTo(y: 0, duration: 1.5))
    }
    
    public func touchUp() {
        self.label.run(SKAction.colorize(with: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), colorBlendFactor: 1.0, duration: .random(in: 1...5)))
    }
    
    public func changeColor() {
        if self.allowColorChange {
            self.label.run(SKAction.colorize(with: UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0), colorBlendFactor: self.blendFactor, duration: 0.02))
        }
    }
    
    public func fadeOutIn() {
        self.label.run(SKAction.sequence([.fadeOut(withDuration: 0.1), .fadeIn(withDuration: 3)]))
    }
}



public class GameScene: SKScene {
    
    private var spitros = [Spitro]()
    
    private var canChangeColor: Bool = false
    private var canPlaySong: Bool = true
    
    private var numberOfSpitros: Int = 0
    
    private var canEndOfApplication: Bool = true
    
    override public func didMove(to view: SKView) {
//#-end-hidden-code
numberOfSpitros = /*#-editable-code Number Of Spitros [integer]*/5/*#-end-editable-code*/
//#-hidden-code
    }
    
    func touchDown(atPoint pos : CGPoint) {
        self.scene?.run(SKAction.playSoundFileNamed("bop3.mp3", waitForCompletion: true)) //Additional sound effects from www.zapsplat.com
        if spitros.count <= self.numberOfSpitros && spitros.count <= 25{
            
            let newSpitro = Spitro(
//#-end-hidden-code
fontColor: /*#-editable-code Type Font Color Literal*/#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)/*#-end-editable-code*/,
text: /*#-editable-code Type Your Text*/""/*#-end-editable-code*/,
textFont: /*#-editable-code Type Text Font*/"HelvetiCANEUE"/*#-end-editable-code*/,
transparency: /*#-editable-code Type Font Transparency [0.0 , 1.0]*/1.0/*#-end-editable-code*/,
textFontSize: /*#-editable-code Type Font Size [integer]*/60/*#-end-editable-code*/,
rotationSpeed: /*#-editable-code Type Spitro's Rotation Speed [0.0 , ...]*/5.0/*#-end-editable-code*/,
orbitalSpeed: /*#-editable-code Type Spitros's Orbital Speed [0.0 , ...]*/8.0/*#-end-editable-code*/,
allowColorChange: /*#-editable-code Type Allow Color Change[true , false]*/true/*#-end-editable-code*/,
blendFactor: /*#-editable-code Type Color Transparency [0.0 , 1.0]*/0.9/*#-end-editable-code*/)
//:
//#-hidden-code
            newSpitro.position = pos
            addChild(newSpitro)
            spitros.append(newSpitro)
        }
        
        self.canChangeColor = true
        for i in spitros { i.touchDown() }
    }
    
    public func endApplication () {
        Timer.scheduledTimer(withTimeInterval: 30, repeats: false, block: {(timer) in
            PlaygroundPage.current.assessmentStatus = .pass(message: "**NICE!** To understand how all this is possible, pause this execution and go to the next page")
        })
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        for i in spitros { i.touchMoved() }
    }
    
    func touchUp(atPoint pos : CGPoint) {
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
        if self.canPlaySong {
            self.scene?.run(SKAction.playSoundFileNamed("bensound-house.mp3", waitForCompletion: true)) //Royalty Free Music from Bensound
            self.canPlaySong = !self.canPlaySong
        }
        
        if self.canEndOfApplication {
            self.endApplication()
            self.canEndOfApplication = !self.canEndOfApplication
        }
        
        if self.canChangeColor { for i in spitros { i.changeColor() } }
        
        for i in spitros { i.rotate() }
        
    }
}

let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 512, height: 768))
if let scene = GameScene(fileNamed: "GameScene2") {
    scene.scaleMode = .aspectFill
    sceneView.presentScene(scene)
}
PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
//#-end-hidden-code
