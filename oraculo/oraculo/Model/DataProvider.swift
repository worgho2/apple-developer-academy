//
//  DataFactory.swift
//  oraculo
//
//  Created by otavio on 14/02/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import Foundation


protocol ReferenceDataProvider {
    func getUser() -> Educator
    func getOccurenceReferences() -> [OccurrenceReference]
}

class MockReference: ReferenceDataProvider {
    
    func getOccurenceReferences() -> [OccurrenceReference] {
        return [
                OccurrenceReference(text: "Didn't do the homework", isActive: false),
                OccurrenceReference(text: "Excessive talk", isActive: false),
                OccurrenceReference(text: "Chewing gum", isActive: false),
                OccurrenceReference(text: "Disrespect", isActive: false),
                OccurrenceReference(text: "Fight at break", isActive: false),
                OccurrenceReference(text: "Committed bullying", isActive: false),
                OccurrenceReference(text: "Using cell phone", isActive: false)
            ]
    }
    
    func getUser() -> Educator {
        return Educator(name: "User", email: "user@gmail.com", accessLevel: .admin)
    }
}
//separar tudo


protocol DataProvider {
    func getStudents() -> [Student]
    func getEducators() -> [Educator]
    func getOccurrences() -> [Occurrence]
    func getTerms() -> [Term]
}

class Mock: DataProvider {
    private enum CharSetType: String {
        case className = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        case name = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        case email = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    }
    
    private func randomString(length: Int, type: CharSetType) -> String {
        let charSet = type.rawValue.map({ String($0) })
        var output = String()
        
        for _ in 0..<length {
            output.append(charSet[Int(arc4random()) % charSet.count])
        }
        
        if type == .email {
            output.append("@email.com")
        }

        return output
    }
    
    func getStudents() -> [Student] {
        var students = [Student]()
        
        for _ in 0...Int.random(in: 10..<100) {
            let name = randomString(length: 10, type: .name)
            let className = randomString(length: 1, type: .className)
            let grade = Int.random(in: 1...9)
            
            let student = Student(name: name, grade: grade, className: className)
            
            student.occurrences = getOccurrences()
            student.terms = getTerms()
            
            students.append(student)
        }
            
        return students
    }
    
    func getEducators() -> [Educator] {
        var educators: [Educator] = [Model.instance.currentUser]
        
        for _ in 0...Int.random(in: 10..<100) {
            let name = randomString(length: 10, type: .name)
            let email = randomString(length: 5, type: .email)
            let accessLevel = AccessLevel.allCases.randomElement()!
            
            let educator = Educator(name: name, email: email, accessLevel: accessLevel)
            
            educators.append(educator)
        }
        
        return educators
    }
    
    func getOccurrences() -> [Occurrence] {
        var occurrences = [Occurrence]()
        
        for _ in 0...Int.random(in: 10..<100) {
            let occurrenceReference = Model.instance.occurrenceReferences.randomElement()!
            let occurrence = Occurrence(reference: occurrenceReference, data: Date())
            
            occurrences.append(occurrence)
        }
        
        return occurrences
    }
    
    func getTerms() -> [Term] {
        return [Term]()
    }    
}
