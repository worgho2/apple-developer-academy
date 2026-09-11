import UIKit
import Charts

class LocalScoreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var myScoreChart: PieChartView!
    
    var correctAnswerDataEntry = PieChartDataEntry(value: 0.0)
    var incorrectAnswerDataEntry = PieChartDataEntry(value: 0.0)
    var totalAnswers = [PieChartDataEntry]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(_ x: Int) {
        if x == 0 {
            self.setupMyScoreChart(description: "Score", correctEntry: Double(Model.instance.scoreBoard.score), incorrectEntry: Double(10 - Model.instance.scoreBoard.score))
        } else {
            self.setupMyScoreChart(description: "Hunch", correctEntry: Double(Model.instance.scoreBoard.fromQuiz!.hunch), incorrectEntry: Double(10 - Model.instance.scoreBoard.fromQuiz!.hunch))
        }
    }
    
    func setupMyScoreChart(description: String, correctEntry: Double, incorrectEntry: Double) {
        self.myScoreChart.chartDescription?.text = description
        self.myScoreChart.chartDescription?.font = UIFont(name: "Kenney Future Narrow", size: 20)!
        self.correctAnswerDataEntry.value = correctEntry
        self.incorrectAnswerDataEntry.value = incorrectEntry
        self.correctAnswerDataEntry.label = "Correct"
        self.incorrectAnswerDataEntry.label = "Incorrect"
        self.totalAnswers = [correctAnswerDataEntry, incorrectAnswerDataEntry]
        self.updateChartData()
    }
    
    func updateChartData() {
        let chartDataSet = PieChartDataSet(entries: self.totalAnswers, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        let colors: [UIColor] = [#colorLiteral(red: 0.5880194902, green: 0.9989247918, blue: 0.5124870539, alpha: 1), #colorLiteral(red: 0.9998300672, green: 0.5853179693, blue: 0.4962604046, alpha: 1)]
        chartDataSet.colors = colors as [NSUIColor]
        
        //LEGENDA
        let legend = myScoreChart.legend
        legend.font = UIFont(name: "Kenney Future Narrow", size: 15)!
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 10
        pFormatter.percentSymbol = " %"
        chartData.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        chartData.setValueFont(UIFont(name: "Kenney Future Narrow", size: 20)!)
        chartData.setValueTextColor(#colorLiteral(red: 0.2901960784, green: 0.3215686275, blue: 0.3529411765, alpha: 1))
        
        myScoreChart.data = chartData
        myScoreChart.highlightValues(nil)
        
        myScoreChart.animate(yAxisDuration: 3, easingOption: .easeOutSine)
    }
    
}
