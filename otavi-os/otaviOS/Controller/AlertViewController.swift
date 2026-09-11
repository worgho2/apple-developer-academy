//
//  AlertViewController.swift
//  otaviOS
//
//  Created by Otavio on 23/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit

enum AlertType: String {
    case warning = "warning"
    case error = "error"
}

struct AlertContent {
    var actionText: String
    var alertType: AlertType
    var description: String
    var content: String
}

class AlertViewController: BaseViewController {
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var alertImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var content: AlertContent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupContent(actionText: content!.actionText, alertType: content!.alertType, description: content!.description, content: content!.content)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if content?.alertType == .warning {
            HapticFeedbackCenter.shared.notification.notificationOccurred(.warning)
            AudioManager.shared.play(soundEffect: .exclamation)
        } else if content?.alertType == .error {
            HapticFeedbackCenter.shared.notification.notificationOccurred(.error)
            AudioManager.shared.play(soundEffect: .error)
        }
    }
    
    private func setupContent(actionText: String, alertType: AlertType, description: String, content: String) {
        self.actionButton.setTitle(actionText, for: .normal)
        self.alertImageView.image = UIImage(named: alertType.rawValue)!
        self.descriptionLabel.text = description
        self.contentLabel.text = content
    }
    
    @IBAction func onAction(_ sender: Any) {
        AudioManager.shared.play(soundEffect: .start)
        HapticFeedbackCenter.shared.impact.impactOccurred()
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func onClose(_ sender: Any) {
        AudioManager.shared.play(soundEffect: .start)
        HapticFeedbackCenter.shared.impact.impactOccurred()
        self.dismiss(animated: false, completion: nil)
    }

}
