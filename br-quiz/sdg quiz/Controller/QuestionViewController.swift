import UIKit
import SpriteKit
import Firebase

class QuestionViewController: UIViewController, ChoiceObserver {
    
    @IBOutlet var superView: UIView!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var categoryColorView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var scoreIndicator_1: UIView!
    @IBOutlet weak var scoreIndicator_2: UIView!
    @IBOutlet weak var scoreIndicator_3: UIView!
    @IBOutlet weak var scoreIndicator_4: UIView!
    @IBOutlet weak var scoreIndicator_5: UIView!
    @IBOutlet weak var scoreIndicator_6: UIView!
    @IBOutlet weak var scoreIndicator_7: UIView!
    @IBOutlet weak var scoreIndicator_8: UIView!
    @IBOutlet weak var scoreIndicator_9: UIView!
    @IBOutlet weak var scoreIndicator_10: UIView!

    @IBOutlet weak var tableImage: UIImageView!
    @IBOutlet weak var tableText: UILabel!
    
    @IBOutlet weak var choiceView: SKView!
    
    var scene: GameScene!
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.choiceView {
            scene = GameScene(size: view.bounds.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
        }
        
        Model.instance.choiseObservers.append(self)
        self.progressView.setProgress(0.0, animated: false)
        self.setupQuestion()
    }
    
    func notity() {
        self.nextQuestion()
    }
    
    func startTimer() {
        let limitTime = 10.0
        let timeControl = 0.001
        let numberOfIncrements = ( limitTime / timeControl )
        let incrementSize = ( 1 / numberOfIncrements )
        var acumulator = 0.0
        
        self.timer = Timer.scheduledTimer(withTimeInterval: timeControl, repeats: true) { (Timer) in
            if acumulator <= 1 {
                acumulator += incrementSize
                self.progressView.setProgress(Float(acumulator), animated: true)
            } else {
                self.stopTimer()
                Model.instance.isTimeOver = true
            }
        }
    }
    
    func stopTimer() {
        if self.timer != nil {
            self.timer!.invalidate()
            self.timer = nil
        }
    }
    
    func setupQuestion() {
        self.startTimer()
        
        self.barView.backgroundColor = UIColor.MyPallete.black
        
        self.categoryColorView.layer.cornerRadius = 10.0
        self.categoryColorView.backgroundColor = Model.instance.basisOfQuestions[Model.instance.currentIndex].categoryColor
        self.categoryLabel.text = Model.instance.basisOfQuestions[Model.instance.currentIndex].category
        
        self.scoreIndicator_1.backgroundColor = self.setupScoreIndicatorColor(0)
        self.scoreIndicator_2.backgroundColor = self.setupScoreIndicatorColor(1)
        self.scoreIndicator_3.backgroundColor = self.setupScoreIndicatorColor(2)
        self.scoreIndicator_4.backgroundColor = self.setupScoreIndicatorColor(3)
        self.scoreIndicator_5.backgroundColor = self.setupScoreIndicatorColor(4)
        self.scoreIndicator_6.backgroundColor = self.setupScoreIndicatorColor(5)
        self.scoreIndicator_7.backgroundColor = self.setupScoreIndicatorColor(6)
        self.scoreIndicator_8.backgroundColor = self.setupScoreIndicatorColor(7)
        self.scoreIndicator_9.backgroundColor = self.setupScoreIndicatorColor(8)
        self.scoreIndicator_10.backgroundColor = self.setupScoreIndicatorColor(9)
        
        self.tableImage.image = UIImage.tableRandomImage
        self.tableText.text = Model.instance.basisOfQuestions[Model.instance.currentIndex].statement
        
        self.scene.updateAnswerValues()
    }
    
    func setupScoreIndicatorColor(_ id: Int) -> UIColor {
         return Model.instance.basisOfQuestions[id].wasResponded ? (Model.instance.basisOfQuestions[id].isCorrect ? UIColor.MyAnswers.correct : UIColor.MyAnswers.incorrect ) : (Model.instance.currentIndex > id ? UIColor.MyAnswers.wasNotResponded : UIColor.MyAnswers.clear)
    }
    
    func nextQuestion() {
        self.stopTimer()
        self.progressView.setProgress(0.0, animated: true)
        
        if Model.instance.currentIndex >= Model.instance.basisOfQuestions.count - 1 {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (Timer) in
                self.quizCompleted()
            }
        } else {
            Model.instance.currentIndex += 1
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (Timer) in
                self.setupQuestion()
            }
        }
    }
    
    func quizCompleted() {
        Model.instance.submitScore()
        self.performSegue(withIdentifier: "segueScore", sender: nil)
    }
}
