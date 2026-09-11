import UIKit
import UIButton_BackgroundContentMode

class NacionalityViewController: UIViewController {
    
    @IBOutlet var superView: UIView!
    @IBOutlet weak var brazilButton: UIButton!
    @IBOutlet weak var brazilImage: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var restOfTheWorldButton: UIButton!
    
    let impact = UIImpactFeedbackGenerator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //VIEW SETUP
        self.superView.backgroundColor = UIColor.MyPallete.black
        
        //BACK BUTTON SETUP
        self.backButton.backgroundColor = .clear
        self.backButton.layer.cornerRadius = super.view.frame.height/55
        self.backButton.layer.borderWidth = 2
        self.backButton.layer.borderColor = UIColor.MyPallete.blue.cgColor
        self.backButton.alpha = 0.8
        
        //BRAZIL BUTTON SETUP
        self.brazilButton.backgroundColor = .clear
        self.brazilButton.layer.cornerRadius = super.view.frame.height/40
        self.brazilButton.layer.borderWidth = 2
        self.brazilButton.layer.borderColor = UIColor.MyPallete.blue.cgColor
        self.brazilImage.layer.cornerRadius = super.view.frame.height/40
        
        //REST OF THE WORLD BUTTON SETUP
        self.restOfTheWorldButton.backgroundColor = .clear
        self.restOfTheWorldButton.layer.cornerRadius = super.view.frame.height/40
        self.restOfTheWorldButton.layer.borderWidth = 2
        self.restOfTheWorldButton.layer.borderColor = UIColor.MyPallete.blue.cgColor
    }
    
    @IBAction func onBrazilButton(_ sender: Any) {
        self.defineNacionalityAndInicialyze(0)
    }
    
    @IBAction func onRestOfTheWorldButton(_ sender: Any) {
        self.defineNacionalityAndInicialyze(1)
    }
    
    func defineNacionalityAndInicialyze(_ nacionality: Int) {
        Model.instance.mainQuiz.setupNationality(nacionality)
        self.impact.impactOccurred()
        
        performSegue(withIdentifier: "segueNacionality", sender: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
