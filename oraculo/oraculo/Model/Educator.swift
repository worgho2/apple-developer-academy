//
//  Educator.swift
//  oraculo
//
//  Created by otavio on 10/02/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

class Educator: Identifiable {
    static var next_id = 0
    
    let id: Int
    var name: String
    var email: String
    var accessLevel: AccessLevel
    
    init(name: String, email: String, accessLevel: AccessLevel = .user) {
        self.id = Educator.next_id
        Educator.next_id += 1
        
        self.name = name
        self.email = email
        self.accessLevel = accessLevel
    }
    
    func assignOccurrence(to student: Student, occurrence: Occurrence) {
        occurrence.assignedBy = self
        student.occurrences.append(occurrence)
    }
}

enum AccessLevel: String, CaseIterable {
    case admin = "Admin"
    case editor = "Editor"
    case user = "User"
}
