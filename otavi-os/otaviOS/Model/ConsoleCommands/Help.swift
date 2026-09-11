//
//  Help.swift
//  otaviOS
//
//  Created by Otavio on 30/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

class Help: ConsoleCommandPack {
    
    override init() {
        super.init()
        
        self.isRootRequired = false
        
        self.dictionary = [
            "" : """
            Utilize o comando [ help ]
            """,
            
            "help" : """
            ------------------------HELP------------------------
            
            Comandos:
                [ exit ]
                [ clear ]
                [ color ]
                [ device ]
                [ otavio ]
                [ metasploit ]
                [ sudo ]
                [ ie ] - root necessário
            
            Todos os comandos possuem suporte ao help.
            
            Exemplo:
                [ otavio ]
                [ otavio -h ]
                [ otavio --help ]
            
            Sintaxe:
                [ <comando> <método> <parâmetro> ]
            
            Obs: Os métodos e parâmetros de cada comando estão listados em seus respectivos comandos de ajuda (help).
            """
        ]
        
    }
    
}
