//
//  EducatorModel.swift
//  oraculo
//
//  Created by otavio on 12/02/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SwiftUI

class Model {
    static let instance = Model()
    
    private let referenceDataProvider: ReferenceDataProvider = MockReference()
    
    @State var currentUser: Educator
    @State var occurrenceReferences: [OccurrenceReference]
    
    private init() {        
        currentUser = referenceDataProvider.getUser()
        occurrenceReferences = referenceDataProvider.getOccurenceReferences()
    }
}
