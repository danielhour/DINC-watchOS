//
//  WTransaction.swift
//  DINC
//
//  Created by dhour on 4/15/16.
//  Copyright © 2016 DHour. All rights reserved.
//

import Foundation
import RealmSwift
import Timepiece


/**
 * Transaction object that's stored specifically on the Watch
 */
class WTransaction: Object {
    
    ///
    var date: NSDate = NSDate()
    ///
    var amount: Double = 0.00
    
    
    convenience init(transaction: WTransaction) {
        self.init()
        
        date = transaction["date"] as? NSDate ?? NSDate()
        amount = transaction["amount"] as? Double ?? 0.00
    }
}