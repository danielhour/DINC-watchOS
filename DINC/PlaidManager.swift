//
//  PlaidManager.swift
//  DINC
//
//  Created by dhour on 4/14/16.
//  Copyright © 2016 DHour. All rights reserved.
//

import Foundation
import SwiftyJSON


/**
 *
 */
class PlaidManager {
    
    
    /**
     Makes the API Request to fetch a user's transactions
     
     - parameter request:    the `FetchTransactions` request
     - parameter completion: completion handler that sends back an array of `Transaction`s
     */
    static func fetchTransactions(request: PlaidService.Router, completion: ([Transaction]?)->()) {
        let plaidService = PlaidService()
        
        plaidService.makeAPIRequest(request) { (error, json) in
            guard error == nil else {
                magic(error!.localizedDescription)
                completion(nil)
                return
            }
            guard let dataArray = json?["transactions"].arrayObject as? [[String: AnyObject]] else {
                magic(JsonError.Empty)
                completion(nil)
                return
            }
            
            let transactions = dataArray.map{Transaction(transaction: $0)}
            completion(transactions)
        }
    }
}