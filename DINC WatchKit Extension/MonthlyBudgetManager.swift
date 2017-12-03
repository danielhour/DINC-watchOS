//
//  SafeToSpendManager.swift
//  DINC
//
//  Created by dhour on 4/16/16.
//  Copyright © 2016 DHour. All rights reserved.
//

import Foundation

/**
 *
 */
struct MonthlyBudgetManager {
    
    /**
     Returns the total allotted monthly budget up to today (day in month * daily budget)
     
     - returns: `Double`
     */
    static func currentTotal() -> Double {
        let db = UserDefaults.standard.integer(forKey: userDefaults.dailyBudget)
        let today = Date.today()
        
        return Double(today.day * db)
    }
    
    /**
     Returns the full monthly budgeted goal (number of days in month * daily budget)
     
     - returns: `Double`
     */
    static func fullMonth() -> Double {
        let db = UserDefaults.standard.integer(forKey: userDefaults.dailyBudget)
        let numberOfDaysInMonth = Date().endOfMonth.day
        
        return Double(numberOfDaysInMonth * db)
    }
    
    
}
