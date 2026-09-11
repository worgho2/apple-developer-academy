//
//  View.swift
//  oraculo
//
//  Created by otavio on 13/02/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SwiftUI

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
