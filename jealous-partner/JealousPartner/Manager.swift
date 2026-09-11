//
//  Manager.swift
//  JealousPartner
//
//  Created by Otávio Baziewicz Filho on 02/05/19.
//  Copyright © 2019 Otávio Baziewicz Filho. All rights reserved.
//

import Foundation
import UIKit

class Manager {
    static var shared = Manager()
    
    var tookPicture = false
    var i = 0
    
    let conversas = [
        Conversa(pergunta: ["Onde você está, que não chegou em casa ainda?", "Tá de brincadeira né? só acredito se mandar uma foto de uma PIZZA"], resposta: "Credo beibe, eu estou numa pizzaria (...)", foto: UIImage(named: "NEXT")!, sucesso: "Desculpa meu amor, você está certo", falha: "Eu já estou cheia de você, está tudo acabado!"),
        Conversa(pergunta: ["Por que não me atendeu quando eu liguei?","Você com essa desculpinha mais uma vez?? Manda foto de um SORVETE pra me provar"], resposta: "Oi meu amor, estou com minha amiga (...)", foto: UIImage(named: "NEXT")!, sucesso: "O meu deus, me desculpe por desconfiar de você!", falha: "Eu sabia que você estava de sacanagem comigo. Acabamos por aqui."),
        Conversa(pergunta: ["Quem é essa menina na foto com você?","Ta tirando com a minha cara? manda foto de uma CANETA pra me provar!"], resposta: "Ela é minha prima amor, estamos (...)", foto: UIImage(named: "NEXT")!, sucesso: "Ai sim meus estudiosos", falha: "EU SABIA SEU DESGRAÇADO! #ACABOU"),
        Conversa(pergunta: ["Quem é essa pessoa que te adicionou no Facebook?","Manda uma foto de uma CRUZ! duvido..."], resposta: "Ela é uma amiga da (...)", foto: UIImage(named: "NEXT")!, sucesso: "Glória a deus amor, descukpa pelo ciúme!", falha: "VAI PROCURAR OUTRA PRA ENGANAR! CHEGA, a-c-a-b-o-u."),
        Conversa(pergunta: ["Por que está tocando uma musica na sua casa? vi no Insta...","Então me manda foto de uma GUITARRA pra provar! miguézeiro."], resposta: "Amor, estamos fazendo (...)", foto: UIImage(named: "NEXT")!, sucesso: "Pau na musiquinha mor, desculpa o ciúmes", falha: "Vai se lascar! CHEGOU PRA MIM!!!!"),
    ]
    
    let escolhas = [
        Escolha(esquerda: "com AMIGOS", direita: "com MULHERES"),
        Escolha(esquerda: "no SHOPPING", direita: "em um ENCONTRO DO TINDER"),
        Escolha(esquerda: "na FACULDADE", direita: "no MOTEL"),
        Escolha(esquerda: "IGREJA", direita: "FACULDADE"),
        Escolha(esquerda: "um ENSAIO DA BANDA", direita: "uma FESTA A FANTASIA")
    ]
    
    let respostas = [
        Gabarito(resposta: "pizza"),
        Gabarito(resposta: "ice"),
        Gabarito(resposta: "pen"),
        Gabarito(resposta: ","),
        Gabarito(resposta: "guitar"),
    ]
    
    private init() {
    }
}
