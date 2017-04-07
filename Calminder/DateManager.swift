//
//  DateManager.swift
//  Calminder
//
//  Created by saekof on 2017-04-04.
//  Copyright © 2017 saeko0032. All rights reserved.
//

import UIKit

class DateManager: NSObject {
    var currentMonthOfDates = [NSDate]()
    var selectedDate = NSDate()
    let daysPerWeek: Int = 7
    var numberOfItems: Int!
    
    func daysForMonth() -> Int {
        let calendar = Calendar.current

        let component = calendar.dateComponents([.day, .month, .year], from: Date())
        let date = calendar.date(from: DateComponents(year: component.year, month: component.month))
        // days
        numberOfItems = calendar.range(of: .day, in: .month, for: date!)?.count
        return numberOfItems
    
    }
    
//    func firstDateOfMonth() -> Date {
//        let components = NSCalendar.current.components([.year, .month, .day], from: selectedDate)
//        components.day = 1
//        let firstDateOfMonth = NSCalendar.current.date(from: components)
//        return firstDateOfMonth
//    
//    }

}
