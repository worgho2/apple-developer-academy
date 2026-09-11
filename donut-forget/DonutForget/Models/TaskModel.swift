//
//  TaskStore.swift
//  DonutForget
//
//  Created by João Conrado Santana de Lima Dembiski on 11/02/20.
//  Copyright © 2020 João Conrado Santana de Lima Dembiski. All rights reserved.
//

import SwiftUI

class TaskModel: ObservableObject {
    
    @Published var wayneTasks: [Task]
    @Published var batmanTasks: [Task]
   
    init () {
        
        self.wayneTasks = [
            Task(name: "wayne1", priority: .no),
            Task(name: "wayne2", priority: .low),
            Task(name: "wayne3", priority: .medium),
            Task(name: "wayne4", priority: .high),
            Task(name: "wayne5", priority: .no),
            Task(name: "wayne6", priority: .low),
            Task(name: "wayne7", priority: .medium),
            Task(name: "wayne8", priority: .high)
        ]
        
        self.batmanTasks = [
            Task(name: "batman1", priority: .no),
            Task(name: "batman2", priority: .low),
            Task(name: "batman3", priority: .medium),
            Task(name: "batman4", priority: .high),
            Task(name: "batman5", priority: .no),
            Task(name: "batman6", priority: .low),
            Task(name: "batman7", priority: .medium),
            Task(name: "batman8", priority: .high)
        ]
    }
    
}
