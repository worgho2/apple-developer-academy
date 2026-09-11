//
//  Clear.swift
//  otaviOS
//
//  Created by Otavio on 30/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

class Clear: ConsoleCommandPack {
    
    override init() {
        super.init()
        
        self.isRootRequired = false
        
        self.dictionary = [
            "clear" : "",
            
            "clear --help" : """
            ------------------------HELP------------------------
            
            O comando limpa o console.
            """,
            
            "clear -h" : """
            ------------------------HELP------------------------
            
            O comando limpa o console.
            """
        ]
        
    }
    
}
