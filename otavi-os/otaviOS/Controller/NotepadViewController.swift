//
//  NotepadViewController.swift
//  otaviOS
//
//  Created by Otavio on 24/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit

class NotepadViewController: BaseViewController {
    
    @IBOutlet weak var notepadView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupContentTextView()
    }
    
    private func setupContentTextView() {
        let text = """
        Bem Vindo ao otaviOS©

        LEIA ANTES DE UTILIZAR!

        1- O objetivo deste aplicativo é revolucionar a industria de sistemas operacionais. Como único representante brasileiro no mercado, otaviOS oferece uma gama de aplicações complexas e úteis.

        2- A versão que está instalada neste dispositivo acompanha:
            [ Console.baza ] : Console com comandos que controlam o funcionamento e a permissão de acesso do sistema.

            [ Internet Explorer ] : Navegador pré-carregado com páginas essenciais para a utilização do sistema.

            [ Read-me.txt ] : Arquivo de texto com informações de utilização do sistema.

            [ Con.crack-V1.exe ] : Software malicioso produzido por terceiros que atua em programas com extensão [ .baza ].
            
        3- Os sons do sistema podem ser mutados a qualquer momento no icone de auto-falante no Desktop.

        4- Os comandos disponíveis no console.baza são descritos através do comando [ help ]. Se um comando disponível for chamado sem nenhum método, o resutado será seu manual de ajuda (help).

        5- Algumas funções estão bloqueadas. Utilize suas habilidades para desbloqueá-las.
        
        6- Divirta-se 👱🏻‍♂️
        """
        
        self.contentTextView.text = text
    }
    
    @IBAction func onClose(_ sender: Any) {
        HapticFeedbackCenter.shared.impact.impactOccurred()
        AudioManager.shared.play(soundEffect: .start)
        self.dismiss(animated: false, completion: nil)
    }

}
