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
    static func delay(_ delay: Double, closure: @escaping (Void) -> Void) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
            execute: closure
        )
    }
}
