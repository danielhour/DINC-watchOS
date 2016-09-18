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
        let converter = NumberFormatter()
        converter.decimalSeparator = "."
        
        let styler = NumberFormatter()
        styler.minimumFractionDigits = 0
        styler.maximumFractionDigits = 0
        styler.currencySymbol = "$"
        styler.numberStyle = .currency
        
        if let result = converter.number(from: self) {
            return styler.string(from: result)!
            
        } else {
            converter.decimalSeparator = ","
            if let result = converter.number(from: self) {
                return styler.string(from: result)!
            }
        }
        
        return ""
    }
    
    /**
     Converts a raw string to a string currency w/ 2 decimals
     */
    var currencyFromString: String {
        let converter = NumberFormatter()
        converter.decimalSeparator = "."
        
        let styler = NumberFormatter()
        styler.minimumFractionDigits = 2
        styler.maximumFractionDigits = 2
        styler.currencySymbol = "$"
        styler.numberStyle = .currency
        
        if let result = converter.number(from: self) {
            let realNumber = Double(result)
            return styler.string(from: NSNumber(value: realNumber))!
            
        } else {
            converter.decimalSeparator = ","
            if let result = converter.number(from: self) {
                return styler.string(from: result)!
            }
        }
        
        return self
    }
    
    /**
     Converts a raw string to a string currency w/ 2 decimals
     */
    var currencyAppend: String {
        let converter = NumberFormatter()
        converter.decimalSeparator = "."
        
        let styler = NumberFormatter()
        styler.minimumFractionDigits = 2
        styler.maximumFractionDigits = 2
        styler.currencySymbol = "$"
        styler.numberStyle = .currency
        
        if let result = converter.number(from: self) {
            let realNumber = Double(result)/100
            return styler.string(from: NSNumber(value: realNumber))!
            
        } else {
            converter.decimalSeparator = ","
            if let result = converter.number(from: self) {
                return styler.string(from: result)!
            }
        }
        
        return ""
    }


}
