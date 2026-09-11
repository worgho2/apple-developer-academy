//
//  File.swift
//  oraculo
//
//  Created by otavio on 13/02/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SwiftUI

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}
