//
//  EndPointType.swift
//  NaukriIndia
//
//  Created by Himanshu Gupta on 31/07/18.
//  Copyright © 2018 Info Edge India Ltd. All rights reserved.
//

import Foundation

protocol ApiEndPointType {
    var baseURL: URL { get }
    var path: String {get}
    var httpMethod: HTTPMethod {get}
    var task: HTTPTask {get}
    var headers: HTTPHeaders{get}
    var showLoader: Bool{get}
    var errorHandlingInVC: Bool{get}

}
extension ApiEndPointType{
    var errorHandlingInVC: Bool {
        return false
    }
    var defaultHeaders: HTTPHeaders{
        return ["Accept-Encoding": "gzip",
                "AppVersion": "1.0",
                "Accept":"application/json",
                "Content-Type" : "application/json"]
    }
}
