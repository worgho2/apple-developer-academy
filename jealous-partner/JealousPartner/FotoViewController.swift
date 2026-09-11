//
//  FotoViewController.swift
//  JealousPartner
//
//  Created by Otávio Baziewicz Filho on 03/05/19.
//  Copyright © 2019 Otávio Baziewicz Filho. All rights reserved.
//

import UIKit

class FotoViewController: UIViewController {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var txtPergunta: UITextView!
    var divisionParam: CGFloat!
    
    override func viewWillAppear(_ animated: Bool) {
        cardView.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2 + 200)
        cardView.transform = .identity
        divisionParam = (self.view.frame.size.width/2)/0.61
        txtPergunta.text = Manager.shared.conversas[Manager.shared.i].pergunta[1]
        Manager.shared.tookPicture = false
    }
    
    @IBAction func fotoPan(_ sender: UIPanGestureRecognizer) {
        let cardView = sender.view!
        let translationPoint = sender.translation(in: view)
        cardView.center = CGPoint(x: self.view.frame.size.width/2 + translationPoint.x, y: self.view.frame.size.height/2 + 200 + translationPoint.y)
        
        if sender.state == UIGestureRecognizer.State.ended {
            if (cardView.center.x > (view.frame.size.width-20)) { // Moved to right
                performSegue(withIdentifier: "segueFoto", sender: nil)
                UIView.animate(withDuration: 0.3, animations: {
                    cardView.center = CGPoint(x: cardView.center.x+200, y: cardView.center.y)
                })
                return
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                cardView.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2 + 200)
                cardView.transform = .identity
            })
        }
        
        let distanceMoved = cardView.center.x - view.center.x
        cardView.transform = CGAffineTransform(rotationAngle: distanceMoved/divisionParam)
    }
    
    
}

