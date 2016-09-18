//
//  NSDateExtensions.swift
//  DINC
//
//  Created by dhour on 4/17/16.
//  Copyright © 2016 DHour. All rights reserved.
//

import Foundation

extension Date {

    /**
     Gets the short weekday symbol for given date
     
     - returns: String
     */
    func dayOfWeek() -> String {
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let symbols = formatter.shortWeekdaySymbols
        let myCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let myComponents = (myCalendar as NSCalendar).components(.weekday, from: self)
        let weekDayIndex = myComponents.weekday!-1
        
        return symbols![weekDayIndex]
    }

}
