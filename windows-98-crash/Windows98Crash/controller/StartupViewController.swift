import UIKit
import AVFoundation

class StartupViewController: UIViewController {
    
    var player: AVAudioPlayer?

    override func viewWillAppear(_ animated: Bool) {
        self.playSound()
        Model.shared.canRestart = true
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "startup", withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()
            self.goToMain()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func goToMain() {
        Timer.scheduledTimer(withTimeInterval: 4, repeats: false, block: {(Timer) in
            self.player?.stop()
            self.performSegue(withIdentifier: "segueStartup", sender: nil)
        })
    }

}








