////
////  DifferenceRoutes.swift
////  Application
////
////  Created by otavio on 15/04/20.
////
//
//import Foundation
//import LoggerAPI
//import Kitura
//
//func initializeDifferenceRoutes(app: App) {
//    app.router.get("/difference", handler: getDifference)
//}
//
//func getDifference(date: String, respondWith: @escaping(DateDiff?, RequestError?) -> Void) {
//    let entryDateDigits = date.compactMap({$0.wholeNumberValue})
//    
//    //Invalid input
//    if entryDateDigits.count != 8 {
//        respondWith(DateDiff(status: "error", daysBetweenDates: 0), nil)
//        return
//    }
//    
//    let day = entryDateDigits[0] * 10 + entryDateDigits[1]
//    let month = entryDateDigits[2] * 10 + entryDateDigits[3]
//    let year = entryDateDigits[4] * 1000 + entryDateDigits[5] * 100 + entryDateDigits[6] * 10 + entryDateDigits[7]
//    
//    //Invalid input
//    if day > 31 || month > 12 {
//        respondWith(DateDiff(status: "error", daysBetweenDates: 0), nil)
//        return
//    }
//    
//    let entryDate = Date().from(day: day, month: month, year: year)
//    respondWith(DateDiff(status: "success", daysBetweenDates: Int(entryDate.timeIntervalSinceNow / (60 * 60 * 24)) ), nil)
//}
