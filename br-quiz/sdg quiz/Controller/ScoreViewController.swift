import UIKit
import Charts

class ScoreViewController: UIViewController {

    @IBOutlet var superView: UIView!
    
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var scoreBoardColorView: UIView!
    @IBOutlet weak var scoreBoardLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
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
    
    @IBOutlet weak var hunchPieChart: PieChartView!
    @IBOutlet weak var scorePieChart: PieChartView!
    
    
    var scoreCorrectAnswerDataEntry = PieChartDataEntry(value: 0.0)
    var scoreIncorrectAnswerDataEntry = PieChartDataEntry(value: 0.0)
    var scoreTotalAnswers = [PieChartDataEntry]()
    
    var hunchCorrectAnswerDataEntry = PieChartDataEntry(value: 0.0)
    var hunchIncorrectAnswerDataEntry = PieChartDataEntry(value: 0.0)
    var hunchTotalAnswers = [PieChartDataEntry]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupScoreBoard()
        self.setupHunchChart()
        self.setupScoreChart()
    }

    func setupScoreBoard() {
        self.superView.backgroundColor = UIColor.MyPallete.white
        self.barView.backgroundColor = UIColor.MyPallete.blue
        
        self.nextButton.backgroundColor = .clear
        self.nextButton.layer.cornerRadius = super.view.frame.height/55
        self.nextButton.layer.borderWidth = 2
        self.nextButton.layer.borderColor = UIColor.MyPallete.blue.cgColor
        self.nextButton.setTitleColor(UIColor.MyPallete.blue, for: .normal)
        
        self.scoreBoardColorView.layer.cornerRadius = 10.0
        self.scoreBoardLabel.backgroundColor = UIColor.MyPallete.black
        
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
    }
    
    func setupScoreIndicatorColor(_ id: Int) -> UIColor {
        return Model.instance.basisOfQuestions[id].wasResponded ? (Model.instance.basisOfQuestions[id].isCorrect ? UIColor.MyAnswers.correct : UIColor.MyAnswers.incorrect ) : (Model.instance.currentIndex > id ? UIColor.MyAnswers.wasNotResponded : UIColor.MyAnswers.clear)
    }
    
    func setupHunchChart() {
        self.hunchPieChart.chartDescription?.text = NSLocalizedString("My Hunch", comment: "")
        self.hunchPieChart.chartDescription?.font = UIFont.myFont(size: 20)
        self.hunchCorrectAnswerDataEntry.value = Double(Model.instance.scoreBoard.fromQuiz!.hunch)
        self.hunchIncorrectAnswerDataEntry.value = Double(10 - Model.instance.scoreBoard.fromQuiz!.hunch)
        self.hunchCorrectAnswerDataEntry.label = NSLocalizedString("Correct", comment: "")
        self.hunchIncorrectAnswerDataEntry.label = NSLocalizedString("Incorrect", comment: "")
        self.hunchTotalAnswers = [hunchCorrectAnswerDataEntry, hunchIncorrectAnswerDataEntry]
        self.updateHunchChartData()
    }
    
    func setupScoreChart() {
        self.scorePieChart.chartDescription?.text = NSLocalizedString("My Score", comment: "")
        self.scorePieChart.chartDescription?.font = UIFont.myFont(size: 20)
        self.scoreCorrectAnswerDataEntry.value = Double(Model.instance.scoreBoard.score)
        self.scoreIncorrectAnswerDataEntry.value = Double(10 - Model.instance.scoreBoard.score)
        self.scoreCorrectAnswerDataEntry.label = NSLocalizedString("Correct", comment: "")
        self.scoreIncorrectAnswerDataEntry.label = NSLocalizedString("Incorrect", comment: "")
        self.scoreTotalAnswers = [scoreCorrectAnswerDataEntry, scoreIncorrectAnswerDataEntry]
        self.updateScoreChartData()
    }
    
    func updateHunchChartData() {
        let chartDataSet = PieChartDataSet(entries: self.hunchTotalAnswers, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        let colors: [UIColor] = [ UIColor.MyAnswers.correct, UIColor.MyAnswers.incorrect ]
        chartDataSet.colors = colors as [NSUIColor]

        let legend = hunchPieChart.legend
        legend.enabled = false
        legend.font = UIFont.myFont(size: 15)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 10
        pFormatter.percentSymbol = " %"
        chartData.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        chartData.setValueFont(UIFont.myFont(size: 20))
        chartData.setValueTextColor(UIColor.MyPallete.black)
        
        hunchPieChart.data = chartData
        hunchPieChart.highlightValues(nil)
        
        hunchPieChart.animate(yAxisDuration: 3, easingOption: .easeOutSine)
    }
    
    func updateScoreChartData() {
        let chartDataSet = PieChartDataSet(entries: self.scoreTotalAnswers, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        let colors: [UIColor] = [ UIColor.MyAnswers.correct, UIColor.MyAnswers.incorrect ]
        chartDataSet.colors = colors as [NSUIColor]
        
        let legend = scorePieChart.legend
        legend.enabled = false
        legend.font = UIFont.myFont(size: 15)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 10
        pFormatter.percentSymbol = " %"
        chartData.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        chartData.setValueFont(UIFont.myFont(size: 20))
        chartData.setValueTextColor(UIColor.MyPallete.black)
        
        scorePieChart.data = chartData
        scorePieChart.highlightValues(nil)
        
        scorePieChart.animate(yAxisDuration: 3, easingOption: .easeOutSine)
    }
    
    @IBAction func onNextButton(_ sender: Any) {
        self.performSegue(withIdentifier: "segueScoreGlobal", sender: nil)
    }
    
}
