//
//  NetworkLogger.swift
//  NaukriIndia
//
//  Created by Himanshu Gupta on 01/08/18.
//  Copyright © 2018 Info Edge India Ltd. All rights reserved.
//

import Foundation

class NetworkLogger {
    static func log(request: URLRequest)->String {
        
        print("\n - - - - - - - - - - OUTGOING REQUEST- - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        
        var logOutput = """
        \(urlAsString) \n\n
        \(method) \(path)?\(query)\n
        HOST: \(host)\n
        """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        
        print(logOutput)
        return logOutput
    }
    
    static func log(response: APIRESPONSE?) -> String {
        print("\n - - - - - - - - - - INCOMING RESPONSE - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        var logOutput = ""
        if let resp = response{
            if let urlAsString = resp.response?.url?.absoluteString{
                print("\n RequestUrl: \(urlAsString)")
                logOutput.append("\n RequestUrl: \(urlAsString)")
            }
            if let responseHeaders = resp.responseHeaders{
                print("\n ResponseHeaders: \(responseHeaders)")
                logOutput.append("\n ResponseHeaders: \(responseHeaders)")
            }
            if let datadict = resp.dataDictionary{
                print("\n Response Data: \(datadict)")
                logOutput.append("\n Response Data: \(datadict)")

            }else{
                if let dataPresent = resp.data{
                    let httpString = String.init(data: dataPresent, encoding: .utf8)
                    print("\n Response NSData: \(String(describing: httpString))")
                    logOutput.append("\n Response NSData: \(String(describing: httpString))")
                }
            }
            if let responseHTTP = resp.responseHTTP{
                print("\n Status Code : \(responseHTTP.statusCode)")
                logOutput.append("\n Status Code : \(responseHTTP.statusCode)")
            }
        }else{
            print("Nil Response")
            logOutput.append("Nil Response")
        }
        return logOutput
    }
}
