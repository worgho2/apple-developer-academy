//
//  SwipeViewController.swift
//  JealousPartner
//
//  Created by Otávio Baziewicz Filho on 03/05/19.
//  Copyright © 2019 Otávio Baziewicz Filho. All rights reserved.
//

import UIKit

class SwipeViewController: UIViewController {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var txtPergunta: UITextView!
    @IBOutlet weak var txtResposta: UITextView!
    @IBOutlet weak var txtNavigation: UINavigationItem!
    @IBOutlet weak var txtEscolha: UITextView!
    
    var divisionParam: CGFloat!
    
    override func viewWillAppear(_ animated: Bool) {
        cardView.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2 + 200)
        cardView.transform = .identity
        divisionParam = (self.view.frame.size.width/2)/0.61
        txtPergunta.text = Manager.shared.conversas[Manager.shared.i].pergunta[0]
        txtResposta.text = Manager.shared.conversas[Manager.shared.i].resposta
        txtNavigation.title = String(Manager.shared.i + 1) + (Manager.shared.i + 1 > 1 ? "˚ ataques de ciúme" : "˚ ataque de ciúme")
        txtEscolha.text = ""
        Manager.shared.tookPicture = false
    }
    
    @IBAction func swipePan(_ sender: UIPanGestureRecognizer) {
        let cardView = sender.view!
        let translationPoint = sender.translation(in: view)
        cardView.center = CGPoint(x: self.view.frame.size.width/2 + translationPoint.x, y: self.view.frame.size.height/2 + 200 + translationPoint.y)
        
        if sender.state == UIGestureRecognizer.State.ended {
            if cardView.center.x < 20 { // Moved to left
                
                UIView.animate(withDuration: 0.3, animations: {
                    cardView.center = CGPoint(x: cardView.center.x-200, y: cardView.center.y)
                })
                performSegue(withIdentifier: "segueEsquerda", sender: nil)
                return
            } else if (cardView.center.x > (view.frame.size.width-20)) { // Moved to right
                UIView.animate(withDuration: 0.3, animations: {
                    cardView.center = CGPoint(x: cardView.center.x+200, y: cardView.center.y)
                })
                performSegue(withIdentifier: "segueDireita", sender: nil)
                return
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                cardView.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2 + 200)
                cardView.transform = .identity
            })
        }
        
        let distanceMoved = cardView.center.x - view.center.x
        
        if distanceMoved > 0 { // moved right side
            txtEscolha.alpha = abs(distanceMoved)/view.center.x
            txtEscolha.text = Manager.shared.escolhas[Manager.shared.i].direita
            txtEscolha.textColor = UIColor.red
        }
        else { // moved left side
            txtEscolha.alpha = abs(distanceMoved)/view.center.x
            txtEscolha.text = Manager.shared.escolhas[Manager.shared.i].esquerda
            txtEscolha.textColor = UIColor.blue
        }
        
        cardView.transform = CGAffineTransform(rotationAngle: distanceMoved/divisionParam)
    }
}

