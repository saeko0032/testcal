//
//  DateManager.swift
//  Calminder
//
//  Created by saekof on 2017-04-04.
//  Copyright © 2017 saeko0032. All rights reserved.
//

import UIKit

class DateManager: NSObject {
    var currentMonthOfDates = [Date]()
    let now = Date()
    let daysPerWeek: Int = 7
    var numberOfItems: Int!
    var numberOfDays: Int!
    
    // how many cells
    func cellsForMonth() -> Int {
        let rangeOfWeeks = Calendar.current.range(of: .weekOfMonth, in: .month, for: firstDateOfMonth())
        let numberOfWeeks = rangeOfWeeks?.count
        numberOfItems = numberOfWeeks! * daysPerWeek
        return numberOfItems
    }
    
    func daysForMonth() -> Int {
        
        let calendar = Calendar.current
        var component = calendar.dateComponents([.day, .month, .year], from: Date())
        let date = (calendar.date(from: DateComponents(year: component.year, month: component.month)))!
        let numberOfDays = calendar.range(of: .day, in: .month, for: date)?.count
        return numberOfDays!
    }
    
    
    func firstDateOfMonth() -> Date {
        let calendar = Calendar.current // replace
        let component = calendar.dateComponents([.day, .month, .year], from: Date())
        let firstDateOfMonth = (calendar.date(from: DateComponents(year: component.year, month: component.month)))!
        return firstDateOfMonth
    }
    
    func ordinalityOfFirstDay() -> Int {
        let ordinalityOfFirstDay = Calendar.current.ordinality(of: .day, in: .weekOfMonth , for: firstDateOfMonth())
        return ordinalityOfFirstDay!
    }
    
    func dateForCellAtIndexPath(numberOfItems: Int) {
        let ordinalityDay = ordinalityOfFirstDay()
    
        for var i in 0...numberOfItems {
            var dateComponents = DateComponents()
            dateComponents.day = i - (ordinalityDay - 1) // 0-(2)
            let firstDate = Calendar.current.date(byAdding: dateComponents, to: firstDateOfMonth())
            currentMonthOfDates.append(firstDate!)
            i += 1
        }
    }
    
    func conversionDateFormat(indexPath: NSIndexPath) -> String {
        dateForCellAtIndexPath(numberOfItems: numberOfItems)
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: currentMonthOfDates[indexPath.row])
    }
    
    
}
