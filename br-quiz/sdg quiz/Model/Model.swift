import UIKit
import Firebase

class Model {
    static let instance = Model()
    
    var basisOfQuestions : [Question] //deixar somente scoreboard no final
    var mainQuiz : Quiz
    var scoreBoard: ScoreBoard
    var currentIndex: Int = 0
    
    var ref: DatabaseReference = Database.database().reference()
    var isTimeOver: Bool = false
    var choiseObservers = [ChoiceObserver]()
    var questionControl: Bool = false {
        didSet {
            self.choiseObservers.forEach( { $0.notity() } )
        }
    }
    
    init() {
        self.basisOfQuestions = [
            Question(statement: NSLocalizedString("q1", comment: ""), answers: [NSLocalizedString("q1a1", comment: ""), NSLocalizedString("q1a2", comment: "")], correctAnswer: 1, category: NSLocalizedString("q1c", comment: ""), categoryColor: UIColor.MyCategories.population),
            Question(statement: NSLocalizedString("q2", comment: ""), answers: [NSLocalizedString("q2a1", comment: ""), NSLocalizedString("q2a2", comment: "")], correctAnswer: 0, category: NSLocalizedString("q2c", comment: ""), categoryColor: UIColor.MyCategories.territory),
            Question(statement: NSLocalizedString("q3", comment: ""), answers: [NSLocalizedString("q3a1", comment: ""), NSLocalizedString("q3a2", comment: "")], correctAnswer: 1, category: NSLocalizedString("q3c", comment: ""), categoryColor: UIColor.MyCategories.territory),
            Question(statement: NSLocalizedString("q4", comment: ""), answers: [NSLocalizedString("q4a1", comment: ""), NSLocalizedString("q4a2", comment: "")], correctAnswer: 1, category: NSLocalizedString("q4c", comment: ""), categoryColor: UIColor.MyCategories.mortality),
            Question(statement: NSLocalizedString("q5", comment: ""), answers: [NSLocalizedString("q5a1", comment: ""), NSLocalizedString("q5a2", comment: "")], correctAnswer: 0, category: NSLocalizedString("q5c", comment: ""), categoryColor: UIColor.MyCategories.incarceration),
            Question(statement: NSLocalizedString("q6", comment: ""), answers: [NSLocalizedString("q6a1", comment: ""), NSLocalizedString("q6a2", comment: "")], correctAnswer: 0, category: NSLocalizedString("q6c", comment: ""), categoryColor: UIColor.MyCategories.energy),
            Question(statement: NSLocalizedString("q7", comment: ""), answers: [NSLocalizedString("q7a1", comment: ""), NSLocalizedString("q7a2", comment: "")], correctAnswer: 0, category: NSLocalizedString("q7c", comment: ""), categoryColor: UIColor.MyCategories.economy),
            Question(statement: NSLocalizedString("q8", comment: ""), answers: [NSLocalizedString("q8a1", comment: ""), NSLocalizedString("q8a2", comment: "")], correctAnswer: 1, category: NSLocalizedString("q8c", comment: ""), categoryColor: UIColor.MyCategories.immigrants),
            Question(statement: NSLocalizedString("q9", comment: ""), answers: [NSLocalizedString("q9a1", comment: ""), NSLocalizedString("q9a2", comment: "")], correctAnswer: 0, category: NSLocalizedString("q9c", comment: ""), categoryColor: UIColor.MyCategories.ignorance),
            Question(statement: NSLocalizedString("q10", comment: ""), answers: [NSLocalizedString("q10a1", comment: ""), NSLocalizedString("q10a2", comment: "")], correctAnswer: 0, category: NSLocalizedString("q10c", comment: ""), categoryColor: UIColor.MyCategories.economy)
        ]
        
        self.mainQuiz = Quiz(questions: self.basisOfQuestions)
        self.scoreBoard = ScoreBoard()
        self.scoreBoard.setQuiz(self.mainQuiz)
        self.syncData()
    }
    
    func syncData(){
        self.ref.child("brazil").observe(.childAdded) { (DataSnapshot) in
            let value = DataSnapshot.value as! NSDictionary
            let response = Response(id: DataSnapshot.key, hunch: value["hunch"] as! Int, score: value["score"] as! Int)
            self.scoreBoard.addFromBrazilResponse(response)
            Timer.scheduledTimer(withTimeInterval: 60, repeats: false, block: { (Timer) in
                self.ref.child("brazil").removeAllObservers()
            })
        }
        
        self.ref.child("global").observe(.childAdded) { (DataSnapshot) in
            let value = DataSnapshot.value as! NSDictionary
            let response = Response(id: DataSnapshot.key, hunch: value["hunch"] as! Int, score: value["score"] as! Int)
            self.scoreBoard.addRestOfTheWorldResponse(response)
            Timer.scheduledTimer(withTimeInterval: 60, repeats: false, block: { (Timer) in
                self.ref.child("global").removeAllObservers()
            })
        }
    }
    
    func submitScore() {
        let score = self.scoreBoard.score
        let hunc = self.scoreBoard.fromQuiz!.hunch
        let nationality = self.scoreBoard.fromQuiz!.nationality
        
        if nationality == 0 {
            self.ref.child("brazil").childByAutoId().setValue(["hunch" : hunc, "score" : score]) { (error, ref) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
        } else if nationality == 1 {
            self.ref.child("global").childByAutoId().setValue(["hunch" : hunc, "score" : score]) { (error, ref) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
        }
    }
    
    func resetQuiz() {
        //RESET CURRENT INDEX
        self.currentIndex = 0
        
        //RESET QUESTION ANSWERS
        for question in basisOfQuestions {
            question.choice = nil
        }
        
        //RESET MAIN QUIZ
        self.mainQuiz.nationality = 0
        self.mainQuiz.hunch = 0
        
        //RESETAR OBSERVER
        self.choiseObservers.removeAll()
    }
}
