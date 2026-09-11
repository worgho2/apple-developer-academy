//
//  Term.swift
//  oraculo
//
//  Created by otavio on 10/02/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

class Term: Identifiable {
    static var next_id = 0
    
    let id: Int
    var content: String
    var data: String
    var assignedBy: Int
    
    init(content: String, data: String, assignedBy: Int) {
        self.id = Term.next_id
        Term.next_id += 1
        
        self.content = content
        self.data = data
        self.assignedBy = assignedBy
    }
}
