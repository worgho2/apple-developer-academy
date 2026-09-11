//
//  Date.swift
//  Application
//
//  Created by otavio on 16/04/20.
//

import Foundation

extension Date {
    
    func from(day: Int, month: Int, year: Int) -> Date {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!

        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day

        return gregorianCalendar.date(from: dateComponents)!
    }
    
}
