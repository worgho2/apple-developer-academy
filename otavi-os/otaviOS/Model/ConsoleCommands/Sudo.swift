//
//  Sudo.swift
//  otaviOS
//
//  Created by Otavio on 30/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

class Sudo: ConsoleCommandPack {
    
    override init() {
        super.init()
        
        self.isRootRequired = false
        
        self.dictionary = [
            "sudo" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ su ] : Efetua login como usuário root.
                    [ -p ] : Parâmetro que antecede a senha.
            
            Exemplo: [ sudo su -p ***** ]
            """,
            
            "sudo --help" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ su ] : Efetua login como usuário root.
                    [ -p ] : Parâmetro que antecede a senha.
            
            Exemplo: [ sudo su -p ***** ]
            """,
            
            "sudo -h" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ su ] : Efetua login como usuário root.
                    [ -p ] : Parâmetro que antecede a senha.
            
            Exemplo: [ sudo su -p ***** ]
            """,
            
            "sudo su -p sacola" : """
            Mudou para usuário: ROOT.
            """
        ]
        
    }
    
}
