//
//  Evento.swift
//  aylto
//
//  Created by Lary Tertuliano on 25/11/19.
//  Copyright © 2019 Gabriel Taques. All rights reserved.
//

import Foundation

class Evento {
    
    internal init(nomeDoEvento: String, dataDoEvento: String, fotoDeCapa: String) {
        self.nomeDoEvento = nomeDoEvento
        self.dataDoEvento = dataDoEvento
        self.fotoDeCapa = fotoDeCapa
    }
    
    
    var nomeDoEvento: String
    var dataDoEvento: String
    var fotoDeCapa: String
}
