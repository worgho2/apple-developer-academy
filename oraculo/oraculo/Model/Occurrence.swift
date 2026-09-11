//
//  Occurrence.swift
//  oraculo
//
//  Created by otavio on 10/02/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation

class Occurrence: Identifiable {
    static var next_id = 0
    
    let id: Int
    let reference: OccurrenceReference
    let data: Date
    var assignedBy: Educator?
    
    init(reference: OccurrenceReference, data: Date) {
        self.id = Occurrence.next_id
        Occurrence.next_id += 1
        
        self.reference = reference
        self.data = data
    }
}
