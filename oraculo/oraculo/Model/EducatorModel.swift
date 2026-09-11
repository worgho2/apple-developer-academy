//
//  EducatorModel.swift
//  oraculo
//
//  Created by otavio on 12/02/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import SwiftUI

class EducatorModel: ObservableObject {
    private let dataProvider: DataProvider = Mock()
    
    @Published var educators: [Educator]
    
    init() {
        educators = dataProvider.getEducators()
    }

}
