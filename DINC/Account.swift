//
//  Account.swift
//  DINC
//
//  Created by dhour on 4/14/16.
//  Copyright © 2016 DHour. All rights reserved.
//

import Foundation


/**
 *
 */
struct Account {
  
    ///
    let institutionName: String
    ///
    let id: String
    ///
    let user: String
    ///
    let balance: Double?
    ///
    let productName: String
    ///
    let lastFourDigits: String
    ///
    let limit: NSNumber?
    ///
    let routingNumber: String?
    ///
    let accountNumber: String?
    ///
    let wireRouting: String?
    
    init (account: [String:AnyObject]) {
        let meta = account["meta"] as! [String:AnyObject]
        let accountBalance = account["balance"] as! [String:AnyObject]
        let numbers = account["numbers"] as? [String:AnyObject]
        
        institutionName = account["institution_type"] as! String
        id = account["_id"] as! String
        user = account["_user"] as! String
        balance = accountBalance["current"] as? Double
        productName = meta["name"] as! String
        lastFourDigits = meta["number"] as! String
        limit = meta["limit"] as? NSNumber
        routingNumber = numbers?["routing"] as? String
        accountNumber = numbers?["account"] as? String
        wireRouting = numbers?["wireRouting"] as? String
    }
}
