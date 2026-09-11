//
//  Exit.swift
//  otaviOS
//
//  Created by Otavio on 30/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

class Exit: ConsoleCommandPack {
    
    override init() {
        super.init()
        
        self.isRootRequired = false
        
        self.dictionary = [
            "exit" : """
            O console irá fechar em instantes.
            """,
            
            "exit --help" : """
            ------------------------HELP------------------------
            
            O comando finaliza o processo do console.
            """,
            
            "exit -h" : """
            ------------------------HELP------------------------
            
            O comando finaliza o processo do console.
            """
        ]
        
    }
    
}
