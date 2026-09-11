//
//  MainPDPatch.swift
//  SynthPD
//
//  Created by otavio on 11/12/20.
//

import Foundation
import libpd_ios

class MainPDPatch: PDPatch {
    var fileName: String = "main.pd"
    
    func openFile() {
        PdBase.openFile(fileName, path: Bundle.main.resourcePath)
        Logger.log(origin: Self.self, "File \(fileName) oppened")
    }
    
    func setOnOffReceiverTo(_ value: Bool) {
        PdBase.send(value ? 1 : 0, toReceiver: "onOff")
        Logger.log(origin: Self.self, "Receiver {onOff} setted to \(value)")
    }
    
    func setXFadeReceiverTo(_ value: Float) {
        PdBase.send(value, toReceiver: "xFade")
        Logger.log(origin: Self.self, "Receiver {xFade} setted to \(value)")
    }
}
