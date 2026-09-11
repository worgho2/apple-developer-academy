//
//  StartupViewController.swift
//  otaviOS
//
//  Created by Otavio on 23/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit

class StartupViewController: BaseViewController {
    
    @IBOutlet weak var startupTextView: UITextView!
    @IBOutlet weak var energyImageView: UIImageView!
    @IBOutlet weak var osBackgroundImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupStartup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Model.instance.skipStartupAnimation {
            self.performSegue(withIdentifier: "segueDesktop", sender: nil)
        } else {
            self.firstStepStartup()
        }
    }
    
    func setupStartup() {
        UIScreen.main.brightness = Model.instance.screenBrightness
        
        self.startupTextView.textColor = .white
        self.startupTextView.backgroundColor = .black
        self.startupTextView.text = "_"
        
        self.energyImageView.isHidden = true
        
        self.osBackgroundImageView.isHidden = true
    }
    

    private func firstStepStartup() {
        
        var flag: Bool = true
        var accumulator: Float = 0
        
        let text = """
            83 Savage Pro (397) Video BIOS. Version 2.1C07a
            Copyright 1999 83 Incorporated.
            _
            """
        
        let text2 = """
            83 Savage Pro (397) Video BIOS. Version 2.1C07a
            Copyright 1999 83 Incorporated.
            """
        
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (t) in
            self.startupTextView.text = flag ? text : text2
            
            flag.toggle()
            accumulator += 0.5
            
            if accumulator >= 4 {
                AudioManager.shared.play(soundEffect: .beep)
                self.secondStepStartup()
                t.invalidate()
            }
        }
    }
    
    private func secondStepStartup() {
        
        var currentIndex: Int = 0
        var accumulator: Float = 0
        var text = [String]()
        
        self.startupTextView.text = ""
        self.energyImageView.isHidden = false
        
        text.append("""
        Award Modular BIOS v4.51PG, An Energy Start Ally
        Copyright (c) 1994-99, Award Software, Inc.
        
        T2A9603B

        """)
        
        text.append("""
        
        PENTIUM 111 CPU at 450 MHz
        Memory Test : 98304K OK

        """)
        
        text.append("""
        
        Award Plug and Play BIOS Extensio v1.0A
        Copyright (c) 1990, Award Software, Inc.

        """)
        
        text.append("""
            Detecting IDE Primary Master --- Maxtor 91360V4

        """)
        
        text.append("""
            Detecting IDE Primary Slave --- Maxtor 82560AM

        """)
        
        text.append("""
            Detecting IDE Secondary --- None

        """)
        
        text.append("""
            Detecting IDE Secondary Slave --- ATAPI CD-ROM

        """)
        
        text.append("""
        \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n
        Press DEL to enter SETUP
        06/03/1999-14402M-SMC60X-ZA69KBOJC-00
        """)
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { (t) in
            self.startupTextView.text += text[currentIndex]
            
            currentIndex = (currentIndex + 1) % (text.count)
            
            accumulator += 1
            
            if Int(accumulator) >= text.count {
                
                Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (_) in
                    self.energyImageView.isHidden = true
                    self.thirdStepStartup()
                }
                
                t.invalidate()
            }
            
        }
        
    }
    
    private func thirdStepStartup() {
        self.startupTextView.text = ""
        self.osBackgroundImageView.alpha = 0
        self.osBackgroundImageView.isHidden = false
        UIView.animate(withDuration: 1) {
            self.osBackgroundImageView.alpha = 1.0
        }
        
        AudioManager.shared.play(soundEffect: .startup)
        
        Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { (_) in
            self.performSegue(withIdentifier: "segueDesktop", sender: nil)
        }
    }
}
