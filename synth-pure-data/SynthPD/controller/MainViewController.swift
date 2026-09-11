//
//  MainViewController.swift
//  SynthPD
//
//  Created by otavio on 10/12/20.
//

import UIKit
import Foundation

class MainViewController: UIViewController {
    
    let manager: PDManager = PDManager.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onSwtich(_ sender: UISwitch) {
//        manager.mainPatch.setOnOffReceiverTo(sender.isOn)
    }
    
    
    @IBAction func onSlider(_ sender: UISlider) {
//        manager.mainPatch.setXFadeReceiverTo(sender.value)
    }
}

