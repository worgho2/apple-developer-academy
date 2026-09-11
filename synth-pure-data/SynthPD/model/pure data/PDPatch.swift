//
//  PDPatch.swift
//  SynthPD
//
//  Created by otavio on 10/12/20.
//

import Foundation

protocol PDPatch {
    var fileName: String { get set }
    func openFile() -> Void
}
