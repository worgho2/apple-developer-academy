//
//  InternetExplorerViewController.swift
//  otaviOS
//
//  Created by Otavio on 29/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit
import WebKit

class InternetExplorerViewController: BaseViewController, WKNavigationDelegate {
    
    @IBOutlet weak var internetExplorerView: UIView!
    @IBOutlet weak var internetExplorerWKWebView: WKWebView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var internetExplorerTitleLabel: UILabel!
    @IBOutlet weak var internetExplorerActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var linkedinButton: UIButton!
    @IBOutlet weak var githubButton: UIButton!
    @IBOutlet weak var appleStoreButton: UIButton!
    
    
    override func loadView() {
        super.loadView()
        self.internetExplorerWKWebView.navigationDelegate = self
        self.internetExplorerWKWebView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://br.linkedin.com/in/otaviobaziewicz")!
        self.internetExplorerWKWebView.load(URLRequest(url: url))
        self.manageFavoriteButtonBackgroudImage(tag: 0)
    }
    
    @IBAction func onClose(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    private func manageFavoriteButtonBackgroudImage(tag: Int) {
        switch tag {
        case 0:
            self.linkedinButton.setBackgroundImage(UIImage(named: "internet_explorer_favorite_pressed"), for: .normal)
            self.githubButton.setBackgroundImage(UIImage(named: "internet_explorer_favorite_normal"), for: .normal)
            self.appleStoreButton.setBackgroundImage(UIImage(named: "internet_explorer_favorite_normal"), for: .normal)
            
        case 1:
            self.linkedinButton.setBackgroundImage(UIImage(named: "internet_explorer_favorite_normal"), for: .normal)
            self.githubButton.setBackgroundImage(UIImage(named: "internet_explorer_favorite_pressed"), for: .normal)
            self.appleStoreButton.setBackgroundImage(UIImage(named: "internet_explorer_favorite_normal"), for: .normal)
            
        case 2:
            self.linkedinButton.setBackgroundImage(UIImage(named: "internet_explorer_favorite_normal"), for: .normal)
            self.githubButton.setBackgroundImage(UIImage(named: "internet_explorer_favorite_normal"), for: .normal)
            self.appleStoreButton.setBackgroundImage(UIImage(named: "internet_explorer_favorite_pressed"), for: .normal)
            
        default:
           self.linkedinButton.setBackgroundImage(UIImage(named: "internet_explorer_favorite_normal"), for: .normal)
           self.githubButton.setBackgroundImage(UIImage(named: "internet_explorer_favorite_normal"), for: .normal)
           self.appleStoreButton.setBackgroundImage(UIImage(named: "internet_explorer_favorite_normal"), for: .normal)
        }
    }
    
    
    
    @IBAction func onFavoriteButtons(_ sender: UIButton) {
        self.manageFavoriteButtonBackgroudImage(tag: sender.tag)
        var url: URL
        
        switch sender.tag {
        case 0:
            url = URL(string: "https://br.linkedin.com/in/otaviobaziewicz")!
        case 1:
            url = URL(string: "https://github.com/worgho2")!
        case 2:
            url = URL(string: "https://apps.apple.com/us/developer/otavio-baziewicz-filho/id1470886246")!
            
        default:
            url = URL(string: "https://google.com")!
        }
        
        self.internetExplorerWKWebView.load(URLRequest(url: url))
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        internetExplorerTitleLabel.text = "Internet Explorer - " + webView.title!
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            if internetExplorerWKWebView.estimatedProgress < 0.85 {
                internetExplorerActivityIndicator.startAnimating()
                internetExplorerActivityIndicator.isHidden = false
            } else {
                internetExplorerActivityIndicator.stopAnimating()
                internetExplorerActivityIndicator.isHidden = true
            }
        }
    }
    
}
