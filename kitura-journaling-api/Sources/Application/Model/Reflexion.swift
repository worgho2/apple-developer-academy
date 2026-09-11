//
//  Reflexion.swift
//  Application
//
//  Created by otavio on 16/04/20.
//

import Foundation
import KituraContracts
import SwiftKueryORM

struct Reflexion: Model {
    var id: String
    var created_at: Date
    var modified_at: Date
    var text: String
}

class ReflexionParams: QueryParams {
    var id: String?
}

class AllRelflexionsParams: QueryParams {
    var from: Date?
    var to: Date?
}
