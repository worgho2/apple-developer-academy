//
//  Metasploit.swift
//  otaviOS
//
//  Created by Otavio on 30/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

class Metasploit: ConsoleCommandPack {
    
    override init() {
        super.init()
        
        self.isRootRequired = false
        
        self.dictionary = [
            "metasploit" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ get-rk ] : Retorna a senha do root.
                    [ -s ] : soft
                    [ -n ] : normal
                    [ -f ] : force
            
            Exemplo: [ metasploit get-rk -s ]
            """,
            
            "metasploit --help" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ get-rk ] : Retorna a senha do root.
                    [ -s ] : soft
                    [ -n ] : normal
                    [ -f ] : force
            
            Exemplo: [ metasploit get-rk -s ]
            """,
            
            "metasploit -h" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ get-rk ] : Retorna a senha do root.
                    [ -s ] : soft
                    [ -n ] : normal
                    [ -f ] : force
            
            Exemplo: [ metasploit get-rk -s ]
            """,
            
            "metasploit get-rk": """
            Erro. Defina um parâmetro para o método [ get-rk ]
            
            Exemplo: [ metasploit get-rk -s ]
            """,
            
            "metasploit get-rk -s" : """
            Falha. O parâmetro [ -s ] suporta somente criptografia MD5.
            
            Utilize o parâmetro [ -n ] : normal
            """,
            
            "metasploit get-rk -n" : """
            Falha. O método [ get-rk ] não obteve sucesso ao tentar quebrar a criptografia SHA256 do sistema root.
            
            Utilize o parâmetro [ -f ] : force
            
            ATENÇÃO: O sistema poderá ser afetado.
            """,
            
            "metasploit get-rk -f" : """
            Sucesso. Senha capturada com êxito!
            
            Senha: sacola
            """
        ]
        
    }
    
}
