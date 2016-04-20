//
//  NSDateExtensions.swift
//  DINC
//
//  Created by dhour on 4/17/16.
//  Copyright © 2016 DHour. All rights reserved.
//

import Foundation

extension NSDate {

    /**
     Gets the short weekday symbol for given date
     
     - returns: String
     */
    func dayOfWeek() -> String {
        
        let formatter  = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let symbols = formatter.shortWeekdaySymbols
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let myComponents = myCalendar.components(.Weekday, fromDate: self)
        let weekDayIndex = myComponents.weekday-1
        
        return symbols[weekDayIndex]
    }

}