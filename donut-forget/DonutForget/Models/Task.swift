//
//  Task.swift
//  DonutForget
//
//  Created by João Conrado Santana de Lima Dembiski on 11/02/20.
//  Copyright © 2020 João Conrado Santana de Lima Dembiski. All rights reserved.
//

import Foundation

class Task: Identifiable {
    let id = UUID()
    
    var name: String
    var completed: Bool
    var priority: TaskPriority
    
    init(name: String, priority: TaskPriority, completed: Bool = false) {
        self.name = name
        self.completed = completed
        self.priority = priority
    }
}

enum TaskPriority: String, CaseIterable {
    case no = "No"
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}
