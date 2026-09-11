//
//  Color.swift
//  otaviOS
//
//  Created by Otavio on 30/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

class Color: ConsoleCommandPack {
    
    override init() {
        super.init()
        
        self.isRootRequired = false
        
        self.dictionary = [
            "color" : """
            ------------------------HELP------------------------
            
            O comando altera a cor do texto do console.
            OBS: Caso a cor da fonte seja a mesma da cor de fundo, o otaviOS© ajustará as cores automaticamente para melhor vizualização.
            
            Métodos:
                [ text ] : Altera a cor do texto
                    [ -white ] : Branco
                    [ -green ] : Verde
                    [ -blue ] : Azul
                    [ -red ] : Vermelho.
            
                [ bg ] : Altera a cor do fundo
                    [ -white ] : Branco
                    [ -green ] : Verde
                    [ -blue ] : Azul
                    [ -red ] : Vermelho.
            
                Exemplo: [ color text -green ]
            """,
            
            "color --help" : """
            ------------------------HELP------------------------
            
            O comando altera a cor do texto do console.
            OBS: Caso a cor da fonte seja a mesma da cor de fundo, o otaviOS© ajustará as cores automaticamente para melhor vizualização.
            
            Métodos:
                [ text ] : Altera a cor do texto
                    [ -white ] : Branco
                    [ -green ] : Verde
                    [ -blue ] : Azul
                    [ -red ] : Vermelho.
            
                [ bg ] : Altera a cor do fundo
                    [ -white ] : Branco
                    [ -green ] : Verde
                    [ -blue ] : Azul
                    [ -red ] : Vermelho.
            
                Exemplo: [ color text -green ]
            """,
            
            "color -h" : """
            ------------------------HELP------------------------
            
            O comando altera a cor do texto do console.
            OBS: Caso a cor da fonte seja a mesma da cor de fundo, o otaviOS© ajustará as cores automaticamente para melhor vizualização.
            
            Métodos:
                [ text ] : Altera a cor do texto
                    [ -white ] : Branco
                    [ -green ] : Verde
                    [ -blue ] : Azul
                    [ -red ] : Vermelho.
            
                [ bg ] : Altera a cor do fundo
                    [ -white ] : Branco
                    [ -green ] : Verde
                    [ -blue ] : Azul
                    [ -red ] : Vermelho.
            
                Exemplo: [ color text -green ]
            """,
            
            "color text -white" : "",
            "color text -green" : "",
            "color text -blue" : "",
            "color text -red" : "",
            "color bg -white" : "",
            "color bg -green" : "",
            "color bg -blue" : "",
            "color bg -red" : ""
        ]
        
    }
    
}
