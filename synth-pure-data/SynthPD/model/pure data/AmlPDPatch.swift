//
//  AmlPDPatch.swift
//  SynthPD
//
//  Created by otavio on 11/12/20.
//

import Foundation
import libpd_ios

class AmlPDPatch: PDPatch {
    var fileName: String = "aml.pd"
    
    func openFile() {
        PdBase.openFile(fileName, path: Bundle.main.resourcePath)
        Logger.log(origin: Self.self, "File \(fileName) oppened")
    }
    
    func setOnOff(_ value: Bool) {
        PdBase.send(value ? 1 : 0, toReceiver: "onOff")
    }
    
    func setVolume(_ value: Float) {
        PdBase.send(value, toReceiver: "volume")
    }
    
    func setOscilator(_ value: Float) {
        PdBase.send(value, toReceiver: "oscilator")
    }
    
    func setPhasor(_ value: Float) {
        PdBase.send(value, toReceiver: "phasor")
    }
    
    func setFilterFreq(_ value: Float) {
        PdBase.send(value, toReceiver: "filterFreq")
    }
    
    func setFilterQ(_ value: Float) {
        PdBase.send(value, toReceiver: "filterQ")
    }
    
    func setFilterFM(_ value: Float) {
        PdBase.send(value, toReceiver: "filterFM")
    }
    
    
}
