//
//  AMLViewController.swift
//  SynthPD
//
//  Created by otavio on 11/12/20.
//

import UIKit

class AMLViewController: UIViewController {
    let manager: PDManager = PDManager.instance
    
    @IBOutlet weak var onOff: UISwitch!
    @IBOutlet weak var volume: UISlider!
    @IBOutlet weak var fm: UISlider!
    @IBOutlet weak var q: UISlider!
    @IBOutlet weak var freq: UISlider!
    @IBOutlet weak var phasor: UISlider!
    @IBOutlet weak var oscilator: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onOff.isOn = false
        manager.amlPatch.setOnOff(onOff.isOn)
        
        volume.minimumValue = 0
        volume.maximumValue = 0.5
        volume.value = 0.5
        manager.amlPatch.setVolume(volume.value)
        
        fm.minimumValue = 0
        fm.maximumValue = 127
        fm.value = 60
        manager.amlPatch.setFilterFM(fm.value)
        
        q.minimumValue = 0
        q.maximumValue = 127
        q.value = 75
        manager.amlPatch.setFilterQ(q.value)
        
        freq.minimumValue = 1.27
        freq.maximumValue = 127
        freq.value = 55
        manager.amlPatch.setFilterFreq(freq.value)
        
        phasor.minimumValue = 0
        phasor.maximumValue = 127
        phasor.value = 20
        manager.amlPatch.setPhasor(phasor.value)
        
        oscilator.minimumValue = 0
        oscilator.maximumValue = 127
        oscilator.value = 35
        manager.amlPatch.setOscilator(oscilator.value)
    }
    
    @IBAction func onOnOff(_ sender: UISwitch) {
        manager.amlPatch.setOnOff(sender.isOn)
    }
    
    @IBAction func onVolume(_ sender: UISlider) {
        manager.amlPatch.setVolume(sender.value)
    }
    
    @IBAction func onFilterFM(_ sender: UISlider) {
        manager.amlPatch.setFilterFM(sender.value)
    }
    
    @IBAction func onFilterQ(_ sender: UISlider) {
        manager.amlPatch.setFilterQ(sender.value)
    }
    
    @IBAction func onFilterFreq(_ sender: UISlider) {
        manager.amlPatch.setFilterFreq(sender.value)
    }
    
    @IBAction func onPhasor(_ sender: UISlider) {
        manager.amlPatch.setPhasor(sender.value)
    }
    
    @IBAction func onOscilator(_ sender: UISlider) {
        manager.amlPatch.setOscilator(sender.value)
    }
    
}
