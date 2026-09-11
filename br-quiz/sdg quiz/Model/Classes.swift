import UIKit

class Response {
    let id: String
    let hunch: Int
    let score: Int

    init(id: String, hunch: Int, score: Int) {
        self.id = id
        self.hunch = (hunch < 0 || hunch > 10) ? ((hunch < 0) ? 0 : 10) : hunch
        self.score = (score < 0 || score > 10) ? ((score < 0) ? 0 : 10) : score
    }
}

class Question {
    static var nextId = 0

    let id: Int
    let statement: String
    let answers: [String]
    let correctAnswer: Int
    let category: String
    let categoryColor: UIColor
    var choice: Int?
    var wasResponded: Bool { return choice != nil }
    var isCorrect: Bool { return ((choice != nil) && (choice == correctAnswer)) }

    init(statement: String, answers: [String], correctAnswer: Int, category: String, categoryColor: UIColor) {
        self.id = Question.nextId
        Question.nextId += 1

        self.statement = statement
        self.correctAnswer = (correctAnswer < 0 || correctAnswer > 1) ? ((correctAnswer < 0) ? 0 : 1) : correctAnswer
        self.answers = answers
        self.category = category
        self.categoryColor = categoryColor
    }

    func setChoice(_ choice: Int) { self.choice = choice }
}

class Quiz {
    static var nextId = 0

    let id: Int
    let questions: [Question]
    var hunch: Int = 0
    var nationality: Int = 0

    init(questions: [Question]) {
        self.id = Question.nextId
        Question.nextId += 1

        self.questions = questions
    }

    func setupHunch(_ hunch: Int) { self.hunch = (hunch < 0 || hunch > 10) ? ((hunch < 0) ? 0 : 10) : hunch }
    func setupNationality(_ nationality: Int) { self.nationality = nationality }
}

class ScoreBoard {
    static var nextId = 0

    let id: Int
    var fromQuiz: Quiz?
    var restOfTheWorld = [Response]()
    var fromBrazil = [Response]()
    
    var fromBrazilScore: Float {
        var totalScore: Int = 0
        let numberOfResponses: Int = self.fromBrazil.count
        
        for response in fromBrazil {
            totalScore += response.score
        }
        
        return Float(Float(totalScore) / Float(numberOfResponses))
    }
    
    var fromBrazilHunch: Float {
        var totalHunch: Int = 0
        let numberOfResponses: Int = self.fromBrazil.count
        
        for response in fromBrazil {
            totalHunch += response.hunch
        }
        
        return Float(Float(totalHunch) / Float(numberOfResponses))
    }
    
    var restOfTheWorldScore: Float {
        var totalScore: Int = 0
        let numberOfResponses: Int = self.restOfTheWorld.count
        
        for response in restOfTheWorld {
            totalScore += response.score
        }
        
        return Float(Float(totalScore) / Float(numberOfResponses))
    }
    
    var restOfTheWorldHunch: Float {
        var totalHunch: Int = 0
        let numberOfResponses: Int = self.restOfTheWorld.count
        
        for response in restOfTheWorld {
            totalHunch += response.hunch
        }
        
        return Float(Float(totalHunch) / Float(numberOfResponses))
    }
    
    var score: Int { return ((self.fromQuiz != nil) ? fromQuiz!.questions.filter( { $0.isCorrect} ).count : 0) }

    init() {
        self.id = ScoreBoard.nextId
        ScoreBoard.nextId += 1
    }

    func setQuiz(_ q: Quiz) { self.fromQuiz = q }
    func addRestOfTheWorldResponse(_ r: Response) { self.restOfTheWorld.append(r) }
    func addFromBrazilResponse(_ r: Response) { self.fromBrazil.append(r) }
}



