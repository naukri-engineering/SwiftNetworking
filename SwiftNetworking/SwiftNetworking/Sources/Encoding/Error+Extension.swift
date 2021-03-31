//
//  Error+Extension.swift
//  SwiftNetworking
//
//  Created by Himanshu Gupta on 28/03/21.
//

import Foundation
extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}
