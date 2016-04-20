//
//  Utilities.swift
//  DINC
//
//  Created by dhour on 4/15/16.
//  Copyright © 2016 DHour. All rights reserved.
//

import Foundation


/**
 A set of global static methods that can be used on any Controller
 */
struct Utilities {
    
    
    /**
     Adds a manual time delay
     
     - parameter delay: Double
     - parameter closure: ()->()
     
     returns: Void
     */
    static func delay(delay: Double, closure: Void -> Void) {
        dispatch_after(
            dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))),
            dispatch_get_main_queue(),
            closure
        )
    }
}