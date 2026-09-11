//
//  Model.swift
//  otaviOS
//
//  Created by Otavio on 23/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit

class Model {
    static let instance = Model()
    
    static let isDebugging: Bool = false
    
    //DEBUG OPTIONS--------------------------
    var isSoundMuted: Bool = false || isDebugging
    var isConsoleCracked: Bool = false || isDebugging
    var hasRootAccess: Bool = false || isDebugging
    var hasInternetExplorerAccess: Bool = false || isDebugging
    var skipStartupAnimation: Bool = false || isDebugging
    //---------------------------------------
    
    var consoleKeys = [String : String]()
    var consoleRootKeys = [String : String]()
    var consoleInvalidCommandError: String
    var consoleRootRequiredError: String
    var consoleFontColor: UIColor = .white
    var consoleBackgroundColor: UIColor = .black
    
    var screenBrightness: CGFloat = UIScreen.main.brightness
    
    func resetOptions() {
        self.isSoundMuted = false || Model.isDebugging
        self.isConsoleCracked = false || Model.isDebugging
        self.hasRootAccess = false || Model.isDebugging
        self.hasInternetExplorerAccess = false || Model.isDebugging
        self.skipStartupAnimation = false || Model.isDebugging
        
        self.consoleFontColor = .white
        self.consoleBackgroundColor = .black
    }
    
    func getConsoleHeader() -> String {
        return "IPHONE_XR:~ " + (self.hasRootAccess ? "root#" : "guest$") + "> "
    }
    
    private init() {
        let avaliableCommandPacks: [ConsoleCommandPack] = [Help(), Exit(), Clear(), Color(), Otavio(), Metasploit(), Sudo(), Device(), Ie()]
        
        for commandPack in avaliableCommandPacks {
            if commandPack.isRootRequired {
                for command in commandPack.dictionary {
                    consoleRootKeys[command.key] = command.value
                }
            } else {
                for command in commandPack.dictionary {
                    consoleKeys[command.key] = command.value
                }
            }
        }
        
        let errors: Error = Error()
        
        self.consoleInvalidCommandError = errors.dictionary["invalid command"]!
        self.consoleRootRequiredError = errors.dictionary["root required"]!
    }
}
