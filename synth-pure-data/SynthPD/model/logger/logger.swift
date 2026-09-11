//
//  logger.swift
//  SynthPD
//
//  Created by otavio on 11/12/20.
//

import Foundation

class Logger {
    
    static func log(origin: Any, _ message: Any ...) {
        NSLog("""
        {
            [\(String(describing: origin))] - \(message)
        }
        """)
    }
    
}
