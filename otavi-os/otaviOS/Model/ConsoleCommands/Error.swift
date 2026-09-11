//
//  Error.swift
//  otaviOS
//
//  Created by Otavio on 30/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

class Error: ConsoleCommandPack {
    
    override init() {
        super.init()
        
        self.isRootRequired = false
        
        self.dictionary = [
            "invalid command" : "O comando é inválido. Utilize o comando [ help ]",
            "root required" : "Erro ao executar comando, o usuário ROOT é necessário."
        ]
        
    }
    
}
