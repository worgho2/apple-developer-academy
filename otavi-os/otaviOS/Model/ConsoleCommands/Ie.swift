//
//  Ie.swift
//  otaviOS
//
//  Created by Otavio on 30/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

class Ie: ConsoleCommandPack {
    
    override init() {
        super.init()
        
        self.isRootRequired = true
        
        self.dictionary = [
            "ie" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ access ] : Muda a permissão de acesso da Internet Explorer.
                    [ -deny ] : Bloqueia o acesso.
                    [ -allow ] : Permite o acesso.
            
            Exemplo: [ ie access -deny ]
            """,
            
            "ie --help" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ access ] : Muda a permissão de acesso da Internet Explorer.
                    [ -deny ] : Bloqueia o acesso.
                    [ -allow ] : Permite o acesso.
            
            Exemplo: [ ie access -deny ]
            """,
            
            "ie -h" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ access ] : Muda a permissão de acesso da Internet Explorer.
                    [ -deny ] : Bloqueia o acesso.
                    [ -allow ] : Permite o acesso.
            
            Exemplo: [ ie access -deny ]
            """,
            
            "ie access -deny" : """
            Internet Explorer: Permissão de acesso alterada para: BLOQUEADO
            """,
            
            "ie access -allow" : """
            Internet Explorer: Permissão de acesso alterada para: PERMITIDO
            """
        ]
        
    }
    
}
