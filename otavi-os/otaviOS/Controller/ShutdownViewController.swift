//
//  ShutdownViewController.swift
//  otaviOS
//
//  Created by Otavio on 29/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit

class ShutdownViewController: BaseViewController {
    
    var isRestart: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AudioManager.shared.play(soundEffect: .shutdown)
        
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (t) in
            UIScreen.main.brightness = CGFloat(0.0)
            t.invalidate()
        }
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (t) in
            self.decideRoute()
            t.invalidate()
        }
    }
    
    private func resetAppConfiguration() {
        Model.instance.resetOptions()
    }

    private func decideRoute() {
        if isRestart ?? false {
            self.restartRoute()
        } else {
            self.shutdownRoute()
        }
    }
    
    private func restartRoute() {
        self.resetAppConfiguration()
        self.performSegue(withIdentifier: "segueStartup", sender: nil)
    }
    
    private func shutdownRoute() {
        UIScreen.main.brightness = Model.instance.screenBrightness
        exit(0)
    }
}
