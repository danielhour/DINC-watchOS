//
//  Enums.swift
//  DINC
//
//  Created by dhour on 4/14/16.
//  Copyright © 2016 DHour. All rights reserved.
//

import Foundation


enum Type {
    case Connect
}

enum Institution: String {
    case amex
    case bofa
    case capone360
    case schwab
    case chase
    case citi
    case fidelity
    case navy
    case pnc
    case suntrust
    case td
    case us
    case usaa
    case wells
}

enum JsonError: ErrorType {
    case Writing
    case Reading
    case Empty
}

enum PlaidError: ErrorType {
    case BadAccessToken
    case CredentialsMissing(String)
    case InvalidCredentials(String)
    case IncorrectMfa(String)
    case InstitutionNotAvailable
}
