//
//  DateManager.swift
//  Calminder
//
//  Created by saekof on 2017-04-04.
//  Copyright © 2017 saeko0032. All rights reserved.
//

import UIKit

class DateManager: NSObject {
    let now = Date()
    let daysPerWeek: Int = 7
    var numberOfItems: Int!
    
    
    
    // how many days you have
    func daysForMonth(selectedCalendar:Calendar?) -> Int {
        let calendar = selectedCalendar
        
        let component = calendar?.dateComponents([.day, .month, .year], from: Date())
        let date = (calendar?.date(from: DateComponents(year: component?.year, month: component?.month)))!
        numberOfItems = calendar?.range(of: .day, in: .month, for: date)?.count
        return numberOfItems
    }
    
    func firstDayOfMonth(selectedCalendar:Calendar?) -> Int {
        return selectedCalendar!.firstWeekday // 1:sun 2:mon 3:tue 4:wed 5:thu 6:fri 7:sat
    }
    
    func firstDateOfMonth() -> Date {
        let calendar = Calendar.current
        
        let component = calendar.dateComponents([.day, .month, .year], from: Date())
        let firstDateOfMonth = (calendar.date(from: DateComponents(year: component.year, month: component.month)))!
    
        return firstDateOfMonth
    }
    
    
    func dateForCellAtIndexPath(selectedCalendar:Calendar?, numberOfItems: Int) {
        let calendar = selectedCalendar
        
        let component = calendar?.dateComponents([.day, .month, .year], from: Date())
        let date = calendar?.date(from: DateComponents(year: component?.year, month: component?.month))
        
        let ordinalityOfFirstDay = selectedCalendar?.ordinality(of: .day, in: .month , for: date!)
    
        for var i in 1...numberOfItems {
            var dateComponents = DateComponents()
            dateComponents.day = i - (ordinalityOfFirstDay! - 1)
            i += 1
            let firstDate = calendar!.date(byAdding: dateComponents, to: firstDateOfMonth())
            //return firstDate
        }
    }
    
    
}
