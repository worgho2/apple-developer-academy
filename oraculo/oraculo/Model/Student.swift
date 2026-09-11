//
//  student.swift
//  oraculo
//
//  Created by otavio on 10/02/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

class Student: Identifiable {
    static var next_id = 0
    
    let id: Int
    var name: String
    var grade: Int
    var className: String
    
    var occurrences: [Occurrence]
    var terms: [Term]
    
    init(name: String, grade: Int, className: String, occurrences: [Occurrence] = [], terms: [Term] = []) {
        self.id = Student.next_id
        Student.next_id += 1
        
        self.name = name
        self.grade = grade
        self.className = className
        self.occurrences = occurrences
        self.terms = terms
    }
}
