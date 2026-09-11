import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene {

    var mainChoice: SKShapeNode?
    var firstChoice: SKShapeNode?
    var secondChoice: SKShapeNode?
    
    var firstChoiceLabel: SKLabelNode?
    var secondChoiceLabel: SKLabelNode?
    
    let notification = UINotificationFeedbackGenerator()
    let impact = UIImpactFeedbackGenerator()
    let selection = UISelectionFeedbackGenerator()
    
    var moving: Bool = false
    var intersected: Bool = false
    var firstIntersected: Bool = false
    var secondIntersected: Bool = false
    var canTouchScreen: Bool = true
    var firstSelected: Bool = false
    var secondSelected: Bool = false
    
    var mainChoiceMinX: CGFloat!
    var mainChoiceMaxX: CGFloat!
    var mainChoiceMinY: CGFloat!
    var mainChoiceMaxY: CGFloat!
    
    var mainChoiceOriginalPosition: CGPoint!
    
    var minFontSize = 12
    var maxFontSize = 30
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.view?.isExclusiveTouch = true
        
        self.backgroundColor = UIColor.MyPallete.black
        
        self.mainChoice = SKShapeNode(circleOfRadius: self.frame.height/8)
        self.mainChoice!.position = CGPoint(x: self.frame.maxX/2, y: self.frame.maxY/4)
        self.mainChoice!.fillColor = Model.instance.mainQuiz.questions[Model.instance.currentIndex].categoryColor
        self.mainChoice!.strokeColor = UIColor.MyAnswers.clear
        self.mainChoice!.alpha = 0.8
        
        self.firstChoice = SKShapeNode(circleOfRadius: self.frame.height/8)
        self.firstChoice!.position = CGPoint(x: 1 * self.frame.maxX/5, y: 3 * self.frame.maxY/5)
        self.firstChoice!.fillColor = UIColor.MyPallete.white
        self.firstChoice!.strokeColor = UIColor.MyAnswers.clear
        self.firstChoice!.zPosition = -1
        
        self.firstChoiceLabel = SKLabelNode(fontNamed: UIFont.myFontName)
        self.firstChoiceLabel!.text = Model.instance.basisOfQuestions[Model.instance.currentIndex].answers[0]
        self.firstChoiceLabel!.position = self.firstChoice!.position
        self.firstChoiceLabel!.horizontalAlignmentMode = .center
        self.firstChoiceLabel!.verticalAlignmentMode = .center
        self.firstChoiceLabel!.fontColor = UIColor.MyPallete.black
        
        self.secondChoice = SKShapeNode(circleOfRadius: self.frame.height/8)
        self.secondChoice!.position = CGPoint(x: 4 * self.frame.maxX/5, y: 3 * self.frame.maxY/5)
        self.secondChoice!.fillColor = UIColor.MyPallete.white
        self.secondChoice!.strokeColor = UIColor.MyAnswers.clear
        self.secondChoice!.zPosition = -1
        
        self.secondChoiceLabel = SKLabelNode(fontNamed: UIFont.myFontName)
        self.secondChoiceLabel!.text = Model.instance.basisOfQuestions[Model.instance.currentIndex].answers[1]
        self.secondChoiceLabel!.position = self.secondChoice!.position
        self.secondChoiceLabel!.horizontalAlignmentMode = .center
        self.secondChoiceLabel!.verticalAlignmentMode = .center
        self.secondChoiceLabel!.fontColor = UIColor.MyPallete.black
        
        self.mainChoiceMinX = firstChoice?.position.x
        self.mainChoiceMaxX = secondChoice?.position.x
        self.mainChoiceMinY = mainChoice?.position.y
        self.mainChoiceMaxY = (firstChoice?.position.y)! + (self.frame.height/8)/2
        self.mainChoiceOriginalPosition = mainChoice!.position
        
        self.addChild(mainChoice!)
        self.addChild(firstChoice!)
        self.addChild(firstChoiceLabel!)
        self.addChild(secondChoice!)
        self.addChild(secondChoiceLabel!)
    }
    
    func touchDown(atPoint pos: CGPoint) {
        
        if self.firstSelected { self.touchUp(atPoint: self.firstChoice!.position)}
        if self.secondSelected { self.touchUp(atPoint: self.secondChoice!.position)}
        
        //TOUCHED MAIN SELECTION CIRCLE
        if mainChoice!.contains(pos) && self.canTouchScreen {
            moving = true
            self.selection.selectionChanged()
        }
            
        //TOUCHED FIRST CHOICE
        else if firstChoice!.contains(pos) && self.canTouchScreen {
            self.firstSelected = true
        }
            
        //TOUCHED SECOND CHOICE
        else if secondChoice!.contains(pos) && self.canTouchScreen {
            self.secondSelected = true
        }
        
    }
   
    func touchMove(atPoint pos: CGPoint) {
        // Pegamos primeiro a posição do X dentro de um quadrado projeto do max e min das coordenadas
        let newX: CGFloat = pos.x < mainChoiceOriginalPosition.x ? max(mainChoiceMinX, pos.x) : min(mainChoiceMaxX, pos.x)
        
        // Multiplicamos o x atual por um passo, onde o passo é determinado por quanto a opçào deve crescer entre o x inicial e o maximo de X
        let step = (mainChoiceMaxY - mainChoiceMinY) / (mainChoiceMaxX - mainChoiceOriginalPosition.x)

        // Calculamos a posição em relação a inicial
        let newY: CGFloat = (abs(newX - mainChoiceOriginalPosition.x) * step) + mainChoiceMinY
        
        let newPos = CGPoint(x: newX, y: newY)
        
        if moving {
            
            //MAIN CHOICE TO FIRST OR SECOND CHOICE
            if (self.firstChoice!.contains(newPos) || self.secondChoice!.contains(newPos)) && !self.intersected {
                self.intersected = true
                self.impact.impactOccurred()
                self.mainChoice!.run(.scale(to: 1.1, duration: 0.1))
                
                //FIRST CHOICE ACTIONS
                if self.firstChoice!.contains(newPos) {
                    self.firstIntersected = true
                    self.firstChoice!.run(.scale(to: 1.1, duration: 0.1))
                    self.mainChoice!.run(.move(to: self.firstChoice!.position, duration: 0.05))
                }
                //SECOND CHOICE ACTIONS
                else if self.secondChoice!.contains(newPos) {
                    self.secondIntersected = true
                    self.secondChoice!.run(.scale(to: 1.1, duration: 0.1))
                    self.mainChoice!.run(.move(to: self.secondChoice!.position, duration: 0.05))
                }
            }
            
            //OUT OF FIRST OR SECOND CHOICE
            else if (!self.firstChoice!.contains(newPos) && !self.secondChoice!.contains(newPos)) && self.intersected {
                self.mainChoice!.run(.scale(to: 0.9, duration: 0.1))
                self.mainChoice!.run(.move(to: newPos, duration: 0.05))
                
                //FIRST CHOICE ACTIONS
                if self.firstIntersected == true {
                    self.firstChoice!.run(.scale(to: 0.9, duration: 0.1))
                }
                //SECOND CHOICE ACTIONS
                else if self.secondIntersected == true {
                    self.secondChoice!.run(.scale(to: 0.9, duration: 0.1))
                }
                
                self.firstIntersected = false
                self.secondIntersected = false
                self.intersected = false
            }
            
            //DEFAULT MOVEMENT
            else if !self.firstChoice!.contains(newPos) && !self.secondChoice!.contains(newPos) {
                self.mainChoice!.run(.move(to: newPos, duration: 0.05))
            }
        }
    }
    
    func touchUp(atPoint pos: CGPoint) {
        //TOUCH STARTED AT MAIN CHOICE
        if moving {
            
            //FIRST CHOICE INTERSECTED BY MAIN CHOICE
            if self.firstIntersected == true {
                self.canTouchScreen = false
                
                //SET FIRST CHOICE
                Model.instance.basisOfQuestions[Model.instance.currentIndex].setChoice(0)
                
                //VISUAL FEEDBACK TO PRESENT CORRECT OR INCORRECT CHOICE
                self.colorizeMainChoiceWithResult(Model.instance.basisOfQuestions[Model.instance.currentIndex].isCorrect)
                
                //SET THE WRONG ANSWER IF TIME IS OVER
                if Model.instance.basisOfQuestions[Model.instance.currentIndex].isCorrect && Model.instance.isTimeOver{
                    Model.instance.basisOfQuestions[Model.instance.currentIndex].setChoice(1)
                }
                
                //NOTIFY MODEL THAT A CHOICE WERE MADE
                Model.instance.questionControl = !Model.instance.questionControl
                
                self.firstChoice!.run(.scale(to: 0.9, duration: 0.1))
                self.mainChoice!.run(.scale(to: 0.9, duration: 0.1))
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (Timer) in
                    self.mainChoice!.run(.move(to: CGPoint(x: self.frame.maxX/2, y: self.frame.maxY/4), duration: 0.2))
                    self.canTouchScreen = true
                }
            }
                
            //SECOND CHOICE INTERSECTED BY MAIN CHOICE
            else if self.secondIntersected == true {
                self.canTouchScreen = false
                
                //SET SECOND CHOICE
                Model.instance.basisOfQuestions[Model.instance.currentIndex].setChoice(1)
                
                //VISUAL FEEDBACK TO PRESENT CORRECT OR INCORRECT CHOICE
                self.colorizeMainChoiceWithResult(Model.instance.basisOfQuestions[Model.instance.currentIndex].isCorrect)
                
                //SET THE WRONG ANSWER IF TIME IS OVER
                if Model.instance.basisOfQuestions[Model.instance.currentIndex].isCorrect && Model.instance.isTimeOver{
                    Model.instance.basisOfQuestions[Model.instance.currentIndex].setChoice(0)
                }

                //NOTIFY MODEL THAT A CHOICE WERE MADE
                Model.instance.questionControl = !Model.instance.questionControl
                
                self.secondChoice!.run(.scale(to: 0.9, duration: 0.1))
                self.mainChoice!.run(.scale(to: 0.9, duration: 0.1))
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (Timer) in
                    self.mainChoice!.run(.move(to: CGPoint(x: self.frame.maxX/2, y: self.frame.maxY/4), duration: 0.1))
                    self.canTouchScreen = true
                }
            }
            
            //NO INTERSECTION BY MAIN CHOICE
            else {
                self.mainChoice!.run(.move(to: CGPoint(x: self.frame.maxX/2, y: self.frame.maxY/4), duration: 0.1))
            }
            moving = false
        }
        
        //TOUCH DIRECTLY AT FIRST CHOICE
        else if self.firstSelected {
            self.canTouchScreen = false
            self.mainChoice!.run(.move(to: self.firstChoice!.position, duration: 0.1)) {
                
                //SET FIRST CHOICE
                Model.instance.basisOfQuestions[Model.instance.currentIndex].setChoice(0)
                
                //VISUAL FEEDBACK TO PRESENT CORRECT OR INCORRECT CHOICE
                self.colorizeMainChoiceWithResult(Model.instance.basisOfQuestions[Model.instance.currentIndex].isCorrect)
                
                //SET THE WRONG ANSWER IF TIME IS OVER
                if Model.instance.basisOfQuestions[Model.instance.currentIndex].isCorrect && Model.instance.isTimeOver{
                    Model.instance.basisOfQuestions[Model.instance.currentIndex].setChoice(1)
                }
                
                //NOTIFY MODEL THAT A CHOICE WERE MADE
                Model.instance.questionControl = !Model.instance.questionControl
                
                self.mainChoice!.run(.scale(to: 1.1, duration: 0.1))
                self.firstChoice!.run(.scale(to: 1.1, duration: 0.1)) {
                    self.firstChoice!.run(.scale(to: 0.9, duration: 0.1))
                    self.mainChoice!.run(.scale(to: 0.9, duration: 0.1))
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (Timer) in
                        self.mainChoice!.run(.move(to: CGPoint(x: self.frame.maxX/2, y: self.frame.maxY/4), duration: 0.2))
                        self.canTouchScreen = true
                    }
                }
            }
            self.firstSelected = false
        }
        
        //TOUCH DIRECTLY AT SECOND CHOICE
        else if self.secondSelected {
            self.canTouchScreen = false
            self.mainChoice!.run(.move(to: self.secondChoice!.position, duration: 0.1)) {
                //SET FIRST CHOICE
                Model.instance.basisOfQuestions[Model.instance.currentIndex].setChoice(1)
                
                //VISUAL FEEDBACK TO PRESENT CORRECT OR INCORRECT CHOICE
                self.colorizeMainChoiceWithResult(Model.instance.basisOfQuestions[Model.instance.currentIndex].isCorrect)
                
                //SET THE WRONG ANSWER IF TIME IS OVER
                if Model.instance.basisOfQuestions[Model.instance.currentIndex].isCorrect && Model.instance.isTimeOver{
                    Model.instance.basisOfQuestions[Model.instance.currentIndex].setChoice(0)
                }
                
                //NOTIFY MODEL THAT A CHOICE WERE MADE
                Model.instance.questionControl = !Model.instance.questionControl
                
                self.mainChoice!.run(.scale(to: 1.1, duration: 0.1))
                self.secondChoice!.run(.scale(to: 1.1, duration: 0.1)) {
                    self.secondChoice!.run(.scale(to: 0.9, duration: 0.1))
                    self.mainChoice!.run(.scale(to: 0.9, duration: 0.1))
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (Timer) in
                        self.mainChoice!.run(.move(to: CGPoint(x: self.frame.maxX/2, y: self.frame.maxY/4), duration: 0.2))
                        self.canTouchScreen = true
                    }
                }
            }
            self.secondSelected = false
        }
    }
    
    func updateAnswerValues() {
        self.firstChoiceLabel!.text! = Model.instance.basisOfQuestions[Model.instance.currentIndex].answers[0]
        self.firstChoiceLabel!.fontSize = calcFontSize(count: self.firstChoiceLabel!.text!.count)
        
        self.secondChoiceLabel!.text! = Model.instance.basisOfQuestions[Model.instance.currentIndex].answers[1]
        self.secondChoiceLabel!.fontSize = calcFontSize(count: self.secondChoiceLabel!.text!.count)
        
        Model.instance.isTimeOver = false
    }
    
    func colorizeMainChoiceWithResult(_ result: Bool) {
        if result == false {
            self.mainChoice!.run(.colorTransitionAction(fromColor: Model.instance.mainQuiz.questions[Model.instance.currentIndex].categoryColor, toColor: UIColor.MyAnswers.incorrect, duration: 0.5)) {
                self.mainChoice!.run(.colorTransitionAction(fromColor: UIColor.MyAnswers.incorrect, toColor: Model.instance.mainQuiz.questions[Model.instance.currentIndex].categoryColor, duration: 0.5))
            }
        } else {
            self.mainChoice!.run(.colorTransitionAction(fromColor: Model.instance.mainQuiz.questions[Model.instance.currentIndex].categoryColor, toColor: UIColor.MyAnswers.correct, duration: 0.5)) {
                self.mainChoice!.run(.colorTransitionAction(fromColor: UIColor.MyAnswers.correct, toColor: Model.instance.mainQuiz.questions[Model.instance.currentIndex].categoryColor, duration: 0.5))
            }
        }
        self.notification.notificationOccurred(result ? (.success) : (.error))
    }
    
    func calcFontSize(count: Int) -> CGFloat {
        return CGFloat(maxFontSize + Int(-pow(Double(count), 1.5)))
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches { touchDown(atPoint: t.location(in: self))}
    }
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches { touchMove(atPoint: t.location(in: self)) }
    }
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
}
