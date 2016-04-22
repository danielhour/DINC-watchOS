//
//  Constants.swift
//  Disposable
//
//  Created by dhour on 4/10/16.
//  Copyright © 2016 DHour. All rights reserved.
//

import Foundation


/**
 *
 */
struct Constants {
    
    struct Plaid {
        static let clientID = ""//Keys.clientID
        static let secret = ""//Keys.secret
        static let accessToken = KeychainWrapper.stringForKey("accessToken") ?? ""
        static let baseURLString = "https://tartan.plaid.com/"
    }
}