//
//  SafeToSpendManager.swift
//  DINC
//
//  Created by dhour on 4/16/16.
//  Copyright © 2016 DHour. All rights reserved.
//

import Foundation
import Timepiece

/**
 *
 */
struct MonthlyBudgetManager {
    
    
    /**
     Returns the total allotted monthly budget up to today (day in month * daily budget)
     
     - returns: `Double`
     */
    static func currentTotal() -> Double {
        let db = NSUserDefaults.standardUserDefaults().integerForKey(userDefaults.dailyBudget)
        let today = NSDate.today()
        
        return Double(today.day * db)
    }
    
    
    /**
     Returns the full monthly budgeted goal (number of days in month * daily budget)
     
     - returns: `Double`
     */
    static func fullMonth() -> Double {
        let db = NSUserDefaults.standardUserDefaults().integerForKey(userDefaults.dailyBudget)
        let numberOfDaysInMonth = NSDate().endOfMonth.day
        
        return Double(numberOfDaysInMonth * db)
    }
    
    
}