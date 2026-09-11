//
//  PDManager.swift
//  SynthPD
//
//  Created by otavio on 10/12/20.
//

import Foundation
import libpd_ios

class PDManager {
    static let instance = PDManager()

    let controller: PdAudioController = PdAudioController()
//    let mainPatch: MainPDPatch = MainPDPatch()
    let amlPatch: AmlPDPatch = AmlPDPatch()
    
    private init() {
        setup()
//        mainPatch.openFile()
        amlPatch.openFile()
    }
    
    private func setup() {
        let configureStatus = controller.configureAmbient(withSampleRate: 48000, numberChannels: 2, mixingEnabled: true)
        
        var description = ""
        switch configureStatus {
        case PdAudioOK:
            description = "success"
            break
        case PdAudioError:
            description = "fail"
            break
        case PdAudioPropertyChanged:
            description = "misconfiguration"
            break
        default:
            break
        }
        
        Logger.log(origin: Self.self, "Setup ended with code \(configureStatus.rawValue): \(description)")
        
        if configureStatus == PdAudioOK {
            start()
        } else {
            stop()
        }
    }

    func start() {
        self.controller.isActive = true
        Logger.log(origin: Self.self, "Controller started")
    }
    
    func stop() {
        self.controller.isActive = false
        Logger.log(origin: Self.self, "Controller stopped")
    }
    
}
