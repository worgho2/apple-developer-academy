//
//  CrackViewController.swift
//  otaviOS
//
//  Created by Otavio on 24/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit

class CrackViewController: BaseViewController {

    @IBOutlet weak var crackView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var targetButton: UIButton!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var crackProgressView: UIProgressView!
    @IBOutlet weak var statusLabel: UILabel!
    
    let targets: [Int : String] = [
        0 : "Notepad.exe",
        1 : "Internet Explorer",
        2 : "Console.baza",
        3 : "Con.crack-V1.exe"
    ]
    var currentTarget: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupContent()
    }
    
    func setupContent() {
        if Model.instance.isConsoleCracked == true {
            self.crackProgressView.setProgress(1, animated: true)
            
            self.statusLabel.text = "Success!"
            self.statusLabel.textColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            
            self.targetButton.isUserInteractionEnabled = false
            self.targetButton.setTitle(self.targets[2], for: .normal)
            
            self.closeButton.isUserInteractionEnabled = true
            
            self.actionButton.setTitle("Exit", for: .normal)
            self.actionButton.isUserInteractionEnabled = true
            return
        }
        
        self.targetButton.setTitle(self.targets[self.currentTarget], for: .normal)
        
        self.statusLabel.text = "Waiting"
        self.statusLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        self.crackProgressView.setProgress(0, animated: false)
        
        self.closeButton.isUserInteractionEnabled = true
        self.targetButton.isUserInteractionEnabled = true
        self.actionButton.isUserInteractionEnabled = true
        
    }

    @IBAction func onClose(_ sender: Any) {
        HapticFeedbackCenter.shared.impact.impactOccurred()
        AudioManager.shared.play(soundEffect: .start)
        
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func onAction(_ sender: Any) {
        HapticFeedbackCenter.shared.impact.impactOccurred()
        AudioManager.shared.play(soundEffect: .start)
        
        if Model.instance.isConsoleCracked == true {
            self.dismiss(animated: false, completion: nil)
            return
        }
        
        self.closeButton.isUserInteractionEnabled = false
        self.targetButton.isUserInteractionEnabled = false
        self.actionButton.isUserInteractionEnabled = false
        
        self.statusLabel.text = "Cracking..."
        self.statusLabel.textColor = #colorLiteral(red: 0.7915803527, green: 0, blue: 0.9635783451, alpha: 1)
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            self.crackProgressView.setProgress(0.1, animated: true)
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                self.crackProgressView.setProgress(0.5, animated: true)
                
                Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                    self.crackProgressView.setProgress(0.8, animated: true)
                    
                    if self.currentTarget == 2 {
                        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
                            HapticFeedbackCenter.shared.notification.notificationOccurred(.success)
                            AudioManager.shared.play(soundEffect: .printComplete)
                            self.crackProgressView.setProgress(1, animated: true)
                            
                            self.statusLabel.text = "Success!"
                            self.statusLabel.textColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
                            
                            self.closeButton.isUserInteractionEnabled = true
                            
                            self.actionButton.setTitle("Exit", for: .normal)
                            self.actionButton.isUserInteractionEnabled = true
                            
                            Model.instance.isConsoleCracked = true
                        }
                    } else {
                        HapticFeedbackCenter.shared.notification.notificationOccurred(.error)
                        AudioManager.shared.play(soundEffect: .error)
                        self.crackProgressView.setProgress(0, animated: false)
                        self.statusLabel.text = "Fail :("
                        self.statusLabel.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                        Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { _ in
                            self.statusLabel.text = "Waiting"
                            self.statusLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                            
                            self.closeButton.isUserInteractionEnabled = true
                            self.targetButton.isUserInteractionEnabled = true
                            self.actionButton.isUserInteractionEnabled = true
                        }
                        
                    }
                }
            }
        }

    }
    
    @IBAction func onTarget(_ sender: Any) {
        HapticFeedbackCenter.shared.selection.selectionChanged()
        AudioManager.shared.play(soundEffect: .menuCommand)
        
        self.currentTarget = (self.currentTarget + 1) % 4
        self.targetButton.setTitle(self.targets[self.currentTarget], for: .normal)
        
        if currentTarget == 2 {
            self.statusLabel.text = "Ready!"
            self.statusLabel.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        } else {
            self.statusLabel.text = "Waiting"
            self.statusLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
}
