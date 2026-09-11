//
//  Conversa.swift
//  JealousPartner
//
//  Created by Otávio Baziewicz Filho on 02/05/19.
//  Copyright © 2019 Otávio Baziewicz Filho. All rights reserved.
//

import Foundation
import UIKit

class Conversa {
    var pergunta: [String]
    var resposta: String
    var foto: UIImage
    var sucesso: String
    var falha: String
    
    init(pergunta: [String], resposta: String, foto: UIImage, sucesso: String, falha: String) {
        self.pergunta = pergunta
        self.resposta = resposta
        self.foto = foto
        self.sucesso = sucesso
        self.falha = falha
    }
}
