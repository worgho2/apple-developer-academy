//
//  ConsoleCommand.swift
//  otaviOS
//
//  Created by Otavio on 30/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

class ConsoleCommandPack {
    var dictionary: [String : String]
    var isRootRequired: Bool
    
    init() {
        self.dictionary = [:]
        self.isRootRequired = false
    }
}
