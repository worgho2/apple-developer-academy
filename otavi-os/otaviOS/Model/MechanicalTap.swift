//
//  MechanicalTap.swift
//  otaviOS
//
//  Created by Otavio on 23/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

class mechanicalTap {
    private var queue = [Int]()
    
    public var isDoubleTap: Bool {
        return queue.count == 2 ? queue[0] == queue[1] : false
    }
    
    public var tappedTag: Int {
        return queue[0]
    }
    
    public func addTap(buttonTag: Int) {
        queue.append(buttonTag)
        clearQueue()
    }
    
    private func clearQueue() {
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (Timer) in
            self.queue.removeAll()
            Timer.invalidate()
        }
    }
}
