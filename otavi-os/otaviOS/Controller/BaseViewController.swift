//
//  BaseViewController.swift
//  otaviOS
//
//  Created by Otavio on 28/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return .bottom
    }

}
