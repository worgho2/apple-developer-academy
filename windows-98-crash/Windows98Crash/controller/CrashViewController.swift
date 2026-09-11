import UIKit
import AVFoundation

class CrashViewController: UIViewController {
    
    @IBOutlet weak var txtCrash: UIImageView!
    var player: AVAudioPlayer?
    
    override func viewWillAppear(_ animated: Bool) {
        self.txtCrash.alpha = 1.0
        self.view.backgroundColor = #colorLiteral(red: 0.01360778417, green: 0.08894344419, blue: 0.556086719, alpha: 1)
        self.defineWindowsError()
    }
    
    func defineWindowsError() {
        var canDiscover = true
        let randomError = Int.random(in: 0 ..< Model.shared.windowsErrors.count)
        self.txtCrash.image = Model.shared.windowsErrors[randomError].image
        
        for i in 0 ..< Model.shared.windowsDiscoveredErrors.count {
            if Model.shared.windowsErrors[randomError].image == Model.shared.windowsDiscoveredErrors[i].image {
                canDiscover = false
            }
        }
        
        if canDiscover {
            Model.shared.windowsDiscoveredErrors.append(Model.shared.windowsErrors[randomError])
        }
        print(".........//Errors")
        print(Model.shared.windowsDiscoveredErrors)
        print(".........//")
    }
    
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "shutdown", withExtension: "wav") else { return }
        
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
    
    @IBAction func restart(_ sender: Any) {
        if Model.shared.canRestart == true{
            Model.shared.canRestart = false
            self.playSound()
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: {(Timer) in // 3
                self.player?.stop()
                self.txtCrash.alpha = 0
                self.view.backgroundColor = .black
            })
            Timer.scheduledTimer(withTimeInterval: 4, repeats: false, block: {(Timer) in //4
                self.performSegue(withIdentifier: "segueRestart", sender: nil)
            })
        }
    }
}
