//
//  HTTPMethod.swift
//  NaukriIndia
//
//  Created by Himanshu Gupta on 01/08/18.
//  Copyright © 2018 Info Edge India Ltd. All rights reserved.
//

import Foundation
public enum HTTPMethod: String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
    case none = ""
    
    init() {
        self = .none
    }
}
