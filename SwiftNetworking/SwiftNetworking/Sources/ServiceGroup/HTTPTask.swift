//
//  HTTPTask.swift
//  NaukriIndia
//
//  Created by Himanshu Gupta on 01/08/18.
//  Copyright © 2018 Info Edge India Ltd. All rights reserved.
//

import Foundation
public typealias HTTPHeaders = [String: String]

public enum HTTPTask{
    case request
    
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
    
    case download(additionHeaders: HTTPHeaders?)

    init() {
        self = .request
    }
}
