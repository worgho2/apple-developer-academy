import UIKit
import AVFoundation

class DesktopViewController: UIViewController {
    
    @IBOutlet weak var btnRecycleBin: UIButton!
    @IBOutlet weak var btnMyComputer: UIButton!
    @IBOutlet weak var btnDrive: UIButton!
    @IBOutlet weak var btnInternetExplorer: UIButton!
    @IBOutlet weak var btnMyDocuments: UIButton!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var btnKeyboard: UIButton!
    @IBOutlet weak var btnPaint: UIButton!
    @IBOutlet weak var btnSound: UIButton!
    
    @IBOutlet weak var criticalView: UIView!
    @IBOutlet weak var btncritical: UIButton!
    @IBOutlet weak var txtCritical: UILabel!
    @IBOutlet weak var txtCriticalBar: UILabel!
    
    @IBOutlet weak var lblHour: UILabel!
    var player: AVAudioPlayer?
    
    var doubleTap: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateTime()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.restoreContent()
        self.resetCritical()
    }
    
    func updateTime() {
        self.lblHour.text = self.getHour()
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (Timer) in
            self.lblHour.text = self.getHour()
        }
    }
    
    func getHour() -> String {
        let formatador = DateFormatter()
        formatador.dateFormat = "HH:mm"
        return formatador.string(from: Date())
    }
    
    func restoreContent() {
        self.btnRecycleBin.setBackgroundImage(Model.shared.btnBackgroundImages[0].normal, for: .normal)
        self.btnMyComputer.setBackgroundImage(Model.shared.btnBackgroundImages[1].normal, for: .normal)
        self.btnDrive.setBackgroundImage(Model.shared.btnBackgroundImages[2].normal, for: .normal)
        self.btnInternetExplorer.setBackgroundImage(Model.shared.btnBackgroundImages[3].normal, for: .normal)
        self.btnMyDocuments.setBackgroundImage(Model.shared.btnBackgroundImages[4].normal, for: .normal)
        self.btnStart.setBackgroundImage(Model.shared.btnBackgroundImages[5].normal, for: .normal)
        self.btnKeyboard.setBackgroundImage(Model.shared.btnBackgroundImages[6].normal, for: .normal)
        self.btnPaint.setBackgroundImage(Model.shared.btnBackgroundImages[7].normal, for: .normal)
        self.btnSound.setBackgroundImage(Model.shared.btnBackgroundImages[8].normal, for: .normal)
    }
    
    func changeBtnBackgroundImage(index: Int) {
        self.restoreContent()
        switch index {
        case 0:
            self.btnRecycleBin.setBackgroundImage(Model.shared.btnBackgroundImages[0].down, for: .normal)
        case 1:
            self.btnMyComputer.setBackgroundImage(Model.shared.btnBackgroundImages[1].down, for: .normal)
        case 2:
            self.btnDrive.setBackgroundImage(Model.shared.btnBackgroundImages[2].down, for: .normal)
        case 3:
            self.btnInternetExplorer.setBackgroundImage(Model.shared.btnBackgroundImages[3].down, for: .normal)
        case 4:
            self.btnMyDocuments.setBackgroundImage(Model.shared.btnBackgroundImages[4].down, for: .normal)
        case 5:
            self.btnStart.setBackgroundImage(Model.shared.btnBackgroundImages[5].down, for: .normal)
        case 6:
            self.btnKeyboard.setBackgroundImage(Model.shared.btnBackgroundImages[6].down, for: .normal)
        case 7:
            self.btnPaint.setBackgroundImage(Model.shared.btnBackgroundImages[7].down, for: .normal)
        case 8:
            self.btnSound.setBackgroundImage(Model.shared.btnBackgroundImages[8].down, for: .normal)
        default:
            print("[Error] - Changing button background Image")
        }
    }
    
    func playSound(name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func resetCritical() {
        self.criticalView.isUserInteractionEnabled = false
        self.criticalView.isHidden = true
    }
    
    func criticalError() {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (Timer) in
            self.playSound(name: "critical")
            self.criticalView.isHidden = false
            self.criticalView.isUserInteractionEnabled = true
            
            var canDiscover = true
            let randomCritical = Int.random(in: 0 ..< Model.shared.windowsTxtCritical.count)
            self.txtCritical.text = Model.shared.windowsTxtCritical[randomCritical]
            
            for i in 0 ..< Model.shared.windowsDiscoveredCritical.count {
                if Model.shared.windowsTxtCritical[randomCritical] == Model.shared.windowsDiscoveredCritical[i] {
                    canDiscover = false
                }
            }
            print(canDiscover)
            if canDiscover == true {
                Model.shared.windowsDiscoveredCritical.append(Model.shared.windowsTxtCritical[randomCritical])
            }
            print(".........//critical")
            print(Model.shared.windowsDiscoveredCritical)
            print(".........//")
            
        }
    }
    
    @IBAction func criticalOk(_ sender: Any) {
        self.playSound(name: "start")
        self.resetCritical()
        
        let probToCrash = Int.random(in: 0 ... 100)
        print(probToCrash)
        if probToCrash >= 70 {
            performSegue(withIdentifier: "segueCrashScreen", sender: nil)
        }
    }
    
    @IBAction func crashSystem(_ sender: UIButton) {
        self.changeBtnBackgroundImage(index: sender.tag)
        self.playSound(name: "start")
        self.doubleTap.append(sender.tag)
        if self.doubleTap.count == 2 {
            if self.doubleTap[0] == self.doubleTap[1] {
                self.criticalError()
            }

        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (Timer) in
            self.doubleTap.removeAll()
        }
    }
    
    @IBAction func clickOnEmpty(_ sender: Any) {
        self.restoreContent()
    }
    
    
    
    
    
    
    
}
