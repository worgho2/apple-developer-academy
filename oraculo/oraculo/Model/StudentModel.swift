//
//  Model.swift
//  oraculo
//
//  Created by otavio on 10/02/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SwiftUI

class StudentModel: ObservableObject {
    private let dataProvider: DataProvider = Mock()
    
    @Published var students: [Student]
    
    init() {
        students = dataProvider.getStudents()
    }
    
}
