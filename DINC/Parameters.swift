//
//  Parameters.swift
//  DINC
//
//  Created by dhour on 4/14/16.
//  Copyright © 2016 DHour. All rights reserved.
//

//import Foundation
//
//
///**
// *  Parameters for PlaidService requests
// */
//struct Parameters {
//    
//    ///
//    var body = [String: AnyObject]()
//    
//    
//    /**
//     Init with `clientID` & `secret`
//     */
//    init() {
//        body["client_id"] = Constants.Plaid.clientID
//        body["secret"] = Constants.Plaid.secret
//    }
//    
//    
//    
//    static func addUserParams(institution: String, username: String, password: String) -> Parameters {
//        var params = Parameters()
//        params.body["type"] = institution
//        params.body["username"] = username
//        params.body["password"] = password
//        
//        var options = [String: AnyObject]()
//        options["list"] = true
//        params.body["options"] = options
//        
//        return params
//    }
//    
//    
//    /**
//     Add parameters to fetch transactions
//     
//     - parameter beginDate: date with `String` format `yyyy-MM-dd`
//     - parameter endDate:   date with `String` format `yyyy-MM-dd`
//     
//     - returns: `Parameters` object to send with request
//     */
//    static func addTransactionParams(beginDate: String, endDate: String) -> Parameters {
//        var params = Parameters()
//        params.body["access_token"] = Constants.Plaid.accessToken
//        
//        var options = [String: AnyObject]()
//        options["pending"] = true
//        options["gte"] = beginDate
//        options["lte"] = endDate
//        params.body["options"] = options
//        
//        return params
//    }
//}
