import UIKit

class HunchViewController: UIViewController {
    
    @IBOutlet var superView: UIView!
    @IBOutlet weak var hunchQuestionLabel: UILabel!
    @IBOutlet weak var hunchSlider: UISlider!
    @IBOutlet weak var nextButton: UIButton!
    
    let impact = UIImpactFeedbackGenerator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //VIEW SETUP
        self.superView.backgroundColor = UIColor.MyPallete.black
        
        //NEXT BUTTON SETUP
        self.nextButton.backgroundColor = .clear
        self.nextButton.layer.cornerRadius = super.view.frame.height/40
        self.nextButton.layer.borderWidth = 2
        self.nextButton.layer.borderColor = UIColor.MyPallete.blue.cgColor
    }
    
    @IBAction func onNext(_ sender: Any) {
        Model.instance.mainQuiz.setupHunch(Int(round(self.hunchSlider.value)))
        self.impact.impactOccurred()
        performSegue(withIdentifier: "segueNext", sender: nil)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let output = Int(sender.value + 0.5)
        sender.value = Float(output)
    }

}
