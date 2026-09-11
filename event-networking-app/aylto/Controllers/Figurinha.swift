//
//  Figurinha.swift
//  aylto
//
//  Created by Lary Tertuliano on 25/11/19.
//  Copyright © 2019 Gabriel Taques. All rights reserved.
//

import Foundation

class Figurinha {
    
    internal init(foto: String, nome: String, frase: String, interesse: String, buscoNoEvento: String) {
        self.foto = foto
        self.nome = nome
        self.frase = frase
        self.interesse = interesse
        self.buscoNoEvento = buscoNoEvento
    }
    
    var foto: String
    var nome: String
    var frase: String
    //code, design, etc
    var interesse: String
    //trabalho, recrutar alguém, happy hour, etc
    var buscoNoEvento: String
    
   
}
