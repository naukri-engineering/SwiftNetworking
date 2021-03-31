//
//  Data+Extension.swift
//  SwiftNetworking
//
//  Created by Himanshu Gupta on 28/03/21.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
