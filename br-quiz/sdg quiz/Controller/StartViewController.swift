import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet var superView: UIView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var informationLabel: UILabel!
    
    let impact = UIImpactFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //VIEW SETUP
        self.superView.backgroundColor = UIColor.MyPallete.white
        
        //START BUTTON SETUP
        self.startButton.backgroundColor = .clear
        self.startButton.layer.cornerRadius = super.view.frame.height/40
        self.startButton.layer.borderWidth = 2
        self.startButton.layer.borderColor = UIColor.MyPallete.blue.cgColor
    }
    
    @IBAction func onStart(_ sender: Any) {
        self.impact.impactOccurred()
        self.performSegue(withIdentifier: "segueHunch", sender: nil)
    }
    
}
