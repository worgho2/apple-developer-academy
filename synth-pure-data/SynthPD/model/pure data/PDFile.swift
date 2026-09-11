//
//  PDFiles.swift
//  SynthPD
//
//  Created by otavio on 10/12/20.
//

import Foundation

enum PDFile: String {
    case main = "main.pd"
    
    func getReceivers() -> [PDPatchReceiver] {
        switch self {
        case .main:
            return [
                .onOff,
                .xFade
            ]
        }
    }
}

enum PDPatchReceiver: String, CaseIterable {
    case onOff = "onOff"
    case xFade = "xFade"
}


