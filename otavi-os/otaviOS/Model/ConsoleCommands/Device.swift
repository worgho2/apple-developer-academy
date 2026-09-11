//
//  Device.swift
//  otaviOS
//
//  Created by Otavio on 30/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit

class Device: ConsoleCommandPack {
    
    override init() {
        super.init()
        
        self.isRootRequired = false
        
        self.dictionary = [
            "device" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ info ] : Retorna as informações do dispositivo, sistema e bateria.
            """,
            
            "device --help" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ info ] : Retorna as informações do dispositivo, sistema e bateria.
            """,
            
            "device -h" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ info ] : Retorna as informações do dispositivo, sistema e bateria.
            """,
            
            "device info" : """
                            Dispositivo:
                                Nome: \(UIDevice.current.name)
                                Modelo: \(UIDevice.current.model)
                                Id: \(UIDevice.current.identifierForVendor!.uuidString)
                                
                            Sistema:
                                Nome: \(UIDevice.current.systemName)
                                Versão: \(UIDevice.current.systemVersion)
                                
                            Bateria:
                                Percentual de carga: \(UIDevice.current.batteryLevel * 100)%
                            """
        ]
        
    }
    
}
