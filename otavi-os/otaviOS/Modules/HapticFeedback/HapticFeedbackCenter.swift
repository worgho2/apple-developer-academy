//
//  HapticFeedbackCenter.swift
//  otaviOS
//
//  Created by Otavio on 25/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit

class HapticFeedbackCenter {
    static let shared = HapticFeedbackCenter()
    
    let notification = UINotificationFeedbackGenerator()
    let impact = UIImpactFeedbackGenerator(style: .soft)
    let selection = UISelectionFeedbackGenerator()
    
    private init() {
    }
}
