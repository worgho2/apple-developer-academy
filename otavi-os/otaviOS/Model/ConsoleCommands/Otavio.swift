//
//  Otavio.swift
//  otaviOS
//
//  Created by Otavio on 30/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

class Otavio: ConsoleCommandPack {
    
    override init() {
        super.init()
        
        self.isRootRequired = false
        
        self.dictionary = [
            "otavio" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ name ] : Retorna o nome.
                [ age ] : Retorna a idade.
                [ nickname ] : Retorna o apelido.
                [ address ] : Retorna o endereço de residência.
                [ birth ] : Retorna a data de nascimento.
                [ interests ] : Retorna os interesses.
                [ email ] : Retorna o email.
                [ occupation ] : Retorna a ocupação.
                [ phone ] : Retorna o número de telefone móvel
            
            Exemplo: [ otavio name ]
            """,
            
            "otavio --help" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ name ] : Retorna o nome.
                [ age ] : Retorna a idade.
                [ nickname ] : Retorna o apelido.
                [ address ] : Retorna o endereço de residência.
                [ birth ] : Retorna a data de nascimento.
                [ interests ] : Retorna os interesses.
                [ email ] : Retorna o email.
                [ occupation ] : Retorna a ocupação.
                [ phone ] : Retorna o número de telefone móvel
            
            Exemplo: [ otavio name ]
            """,
            
            "otavio -h" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ name ] : Retorna o nome.
                [ age ] : Retorna a idade.
                [ nickname ] : Retorna o apelido.
                [ address ] : Retorna o endereço de residência.
                [ birth ] : Retorna a data de nascimento.
                [ interests ] : Retorna os interesses.
                [ email ] : Retorna o email.
                [ occupation ] : Retorna a ocupação.
                [ phone ] : Retorna o número de celular.
            
            Exemplo: [ otavio name ]
            """,
            
            "otavio name" : "Nome: Otávio Baziewicz Filho",
            
            "otavio age" : "Idade: 21 Anos",
            
            "otavio nickname" : "Apelido: Baza",
            
            "otavio address" : "Rua José Zaleski, 674 - ap 344",
            
            "otavio birth" : "Data de nascimento: 16/05/1998",
            
            "otavio interests" : """
            Interesses:
                Segurança de dados
                Programação
                Negócios
                Design de interação
                Skateboard
                Vôlei
                Culinária
                DIY
                Organização
            """,
            
            "otavio email" : "Email: otavio.baziewicz.filho@gmail.com",
            
            "otavio occupation" : "Ocupação: Desenvolvedor",
            
            "otavio phone" : "Celular: (41) 9 9689-2354"
        ]
        
    }
    
}
