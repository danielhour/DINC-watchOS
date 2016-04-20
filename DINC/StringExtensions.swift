//
//  StringExtensions.swift
//  DINC
//
//  Created by dhour on 4/14/16.
//  Copyright © 2016 DHour. All rights reserved.
//

import Foundation


extension String {
    var encodValue:String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
    }
}


extension NSString {
    var encodValue:String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
    }
}


extension NSDate {
    var formatForPlaid: String {
        return self.stringFromFormat("yyyy-MM-dd")
    }
}