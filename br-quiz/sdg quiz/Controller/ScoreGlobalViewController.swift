import UIKit
import Charts

class ScoreGlobalViewController: UIViewController, ChartViewDelegate {

    @IBOutlet var superView: UIView!
    
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var scoreBoardColorView: UIView!
    @IBOutlet weak var scoreBoardLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
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
    
    @IBOutlet weak var barChartView: BarChartView!
    
    let titles = [NSLocalizedString("Score", comment: ""), NSLocalizedString("Hunch", comment: "")]
    let you = [Float(Model.instance.scoreBoard.score) , Float(Model.instance.scoreBoard.fromQuiz!.hunch) ]
    let brazil = [ Model.instance.scoreBoard.fromBrazilScore , Model.instance.scoreBoard.fromBrazilHunch ]
    let world = [Model.instance.scoreBoard.restOfTheWorldScore , Model.instance.scoreBoard.restOfTheWorldHunch ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupScoreBoard()
        
        self.barChartView.noDataText = NSLocalizedString("Error", comment: "")
        if self.you.count != 0 || self.brazil.count != 0 || self.world.count != 0 {
            self.setupChart()
        }
        
    }
    
    func setupScoreBoard() {
        self.superView.backgroundColor = UIColor.MyPallete.white
        self.barView.backgroundColor = UIColor.MyPallete.blue
        
        self.backButton.backgroundColor = .clear
        self.backButton.layer.cornerRadius = super.view.frame.height/55
        self.backButton.layer.borderWidth = 2
        self.backButton.layer.borderColor = UIColor.MyPallete.white.cgColor
        self.backButton.setTitleColor(UIColor.MyPallete.white, for: .normal)
        
        self.resetButton.backgroundColor = .clear
        self.resetButton.layer.cornerRadius = super.view.frame.height/40
        self.resetButton.layer.borderWidth = 2
        self.resetButton.layer.borderColor = UIColor.MyPallete.black.cgColor
        self.resetButton.setTitleColor(UIColor.MyPallete.black, for: .normal)
        
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
    
    func setupChart() {
        barChartView.delegate = self
        barChartView.noDataText = NSLocalizedString("Error", comment: "")
        barChartView.chartDescription?.text = NSLocalizedString("Graph Title", comment: "")
        
        //LEGENDA
        let legend = barChartView.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 10.0;
        legend.xOffset = 10.0;
        legend.yEntrySpace = 0.0;
        legend.font = UIFont.myFont(size: 15)
        
        //BARRA VERTICAL
        let xaxis = barChartView.xAxis
        xaxis.drawGridLinesEnabled = true
        xaxis.labelPosition = .bottom
        xaxis.centerAxisLabelsEnabled = true
        xaxis.valueFormatter = IndexAxisValueFormatter(values:self.titles)
        xaxis.labelFont = UIFont.myFont(size: 15)
        xaxis.granularity = 1
        
        //BARRA HORIZONTAL
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.maximumFractionDigits = 1
        
        let yaxis = barChartView.leftAxis
        yaxis.spaceTop = 0.35
        yaxis.axisMinimum = 0
        yaxis.drawGridLinesEnabled = false
        yaxis.labelFont = UIFont.myFont(size: 15)
        
        barChartView.rightAxis.enabled = false
        
        setChartData()
    }
    
    func setChartData() {
        barChartView.noDataText = NSLocalizedString("Error", comment: "")
        var youDataEntries: [BarChartDataEntry] = []
        var brazilDataEntries: [BarChartDataEntry] = []
        var worldDataEntries: [BarChartDataEntry] = []
        
        for i in 0..<self.titles.count {
            let youDataEntry = BarChartDataEntry(x: Double(i) , y: Double(self.you[i]))
            let brazilDataEntry = BarChartDataEntry(x: Double(i) , y: Double(self.brazil[i]))
            let worldDataEntry = BarChartDataEntry(x: Double(i) , y: Double(self.world[i]))
            
            youDataEntries.append(youDataEntry)
            brazilDataEntries.append(brazilDataEntry)
            worldDataEntries.append(worldDataEntry)
        }
        
        let youDataSet = BarChartDataSet(entries: youDataEntries, label: NSLocalizedString("You", comment: ""))
        let brazilDataSet = BarChartDataSet(entries: brazilDataEntries, label: NSLocalizedString("Brazil", comment: ""))
        let worldDataSet = BarChartDataSet(entries: worldDataEntries, label: NSLocalizedString("World", comment: ""))
        
        youDataSet.colors = [UIColor.MyAnswers.correct]
        brazilDataSet.colors = [UIColor.MyPallete.green]
        worldDataSet.colors = [UIColor.MyPallete.blue]
        
        let dataSets: [BarChartDataSet] = [ youDataSet, brazilDataSet, worldDataSet ]
        
        let chartData = BarChartData(dataSets: dataSets)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 10
        pFormatter.percentSymbol = " %"
        chartData.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        chartData.setValueFont(UIFont.myFont(size: 15))
        chartData.setValueTextColor(UIColor.MyPallete.black)
        
        let groupSpace = 0.25
        let barSpace = 0.05
        let barWidth = 0.2
        // (0.2 + 0.05) * 3 + 0.25 = 1.00 -> current used
        // (0.3 + 0.05) * 2 + 0.3 = 1.00 -> interval per "group"
        
        let groupCount = 2
        let minimumScore = 0
        
        chartData.barWidth = barWidth;
        barChartView.xAxis.axisMinimum = Double(minimumScore)
        let gg = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        barChartView.xAxis.axisMaximum = Double(minimumScore) + gg * Double(groupCount)
        
        chartData.groupBars(fromX: Double(minimumScore), groupSpace: groupSpace, barSpace: barSpace)
        _ = chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace)
        barChartView.notifyDataSetChanged()
        
        barChartView.data = chartData
        
        //background color
        barChartView.backgroundColor = UIColor.MyPallete.white
        
        //chart animation
        barChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
    }
    
    @IBAction func onBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onResetButton(_ sender: Any) {
        Model.instance.resetQuiz()
        navigationController?.popToRootViewController(animated: true)
    }
}
