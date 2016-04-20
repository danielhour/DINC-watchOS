//
//  StringExtensions.swift
//  DINC
//
//  Created by dhour on 4/15/16.
//  Copyright © 2016 DHour. All rights reserved.
//

import Foundation


extension String {
    
    
    /**
     Currency w/o decimals
     */
    var currencyNoDecimals: String {
        let converter = NSNumberFormatter()
        converter.decimalSeparator = "."
        
        let styler = NSNumberFormatter()
        styler.minimumFractionDigits = 0
        styler.maximumFractionDigits = 0
        styler.currencySymbol = "$"
        styler.numberStyle = .CurrencyStyle
        
        if let result = converter.numberFromString(self) {
            return styler.stringFromNumber(result)!
            
        } else {
            converter.decimalSeparator = ","
            if let result = converter.numberFromString(self) {
                return styler.stringFromNumber(result)!
            }
        }
        
        return ""
    }
    
    
    /**
     Converts a raw string to a string currency w/ 2 decimals
     */
    var currencyFromString: String {
        let converter = NSNumberFormatter()
        converter.decimalSeparator = "."
        
        let styler = NSNumberFormatter()
        styler.minimumFractionDigits = 2
        styler.maximumFractionDigits = 2
        styler.currencySymbol = "$"
        styler.numberStyle = .CurrencyStyle
        
        if let result = converter.numberFromString(self) {
            let realNumber = Double(result)/100
            return styler.stringFromNumber(realNumber)!
            
        } else {
            converter.decimalSeparator = ","
            if let result = converter.numberFromString(self) {
                return styler.stringFromNumber(result)!
            }
        }
        
        return ""
    }

}