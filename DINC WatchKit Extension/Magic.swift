//
//  Magic.swift
//
//  Created by Arthur Sabintsev on 1/28/15.
//  Copyright (c) 2015 Arthur Ariel Sabintsev. All rights reserved.
//

import Foundation

/**
 Writes the textual representation of `object` and a newline character into the standard output.
 The textual representation is obtained from the `object` using its protocol conformances,
 in the following order of preference: `Streamable`, `Printable`, `DebugPrintable`.
 
 This function also augments the original function with the filename, function name, and line number of the object that is being logged.
 
 - parameter object:   A textual representation of the object.
 - parameter file:     Defaults to the name of the file that called magic(). Do not override this default.
 - parameter function: Defaults to the name of the function within the file in which magic() was called. Do not override this default.
 - parameter line:     Defaults to the line number within the file in which magic() was called. Do not override this default.
 
 */
func magic<T>(_ message: T, filename: String = #file, line: Int = #line, function: String = #function) {
    let fileString = filename as NSString
    let fileLastPathComponent = fileString.lastPathComponent as NSString
    print("\((fileLastPathComponent)):\(line) \(function):\n\(message)\n")
}

//public func magic<T>(message: String, _ file: String = #file, _ function: String = #function, line: Int = #line) {
//    let fileString = file as NSString
//    let fileLastPathComponent = fileString.lastPathComponent as NSString
//    let filename = fileLastPathComponent.stringByDeletingPathExtension
//    print("\(filename).\(function)[\(line)]:\n\(message)\n\n", terminator: "")
//}
